//--------------------------------------//
// Weapon Import to kf by Exod (erick610)//
// Bugfixed, enhanced and balanced for HMg by [ScrN]PooSH
//--------------------------------------//
class Stinger extends KFWeapon
    config(user);


struct AnimSeq {
    var name AnimName;      // sequence name
    var float AnimRateMult; // additional animation rate multiplier (it will be mulpilied by ReloadAnimRate and ReloadBonus)
    var float TweenTime;
    var int   SkipFrames;   // how many frames to skip from the begining of animation. Animation ending can be skipped by limiting Duration
    var float  Duration;    // how long till the next animation (it will be mulpilied by ReloadAnimRate and ReloadBonus)

    var string SoundRef;    //reference to the sound that should be played
    var sound  Sound;       //sound that should be played during this animation

};
var array<AnimSeq> ReloadAnims;

var float ReloadBonus; //perked reload multiplier
var transient float NextReloadAnimTime; // time when the next part of reload animation sequence must be played
var transient int NextReloadAnimIndex; // index of the next animation in ReloadAnims to play

var transient int OldMagAmmoRemaining;



static function PreloadAssets(Inventory Inv, optional bool bSkipRefCount)
{
    local int i;
    local Stinger W;

    super.PreloadAssets(Inv, bSkipRefCount);

    W = Stinger(Inv);

    for ( i = 0; i < default.ReloadAnims.Length; ++i ) {
        if ( default.ReloadAnims[i].Sound == none && default.ReloadAnims[i].SoundRef != "" )
            default.ReloadAnims[i].Sound = sound(DynamicLoadObject(default.ReloadAnims[i].SoundRef, class'sound'));
        if ( W != none ) {
            W.ReloadAnims[i].Sound = default.ReloadAnims[i].Sound;
        }
    }
}
static function bool UnloadAssets()
{
    local int i;

    for ( i = 0; i < default.ReloadAnims.Length; ++i ) {
        if ( default.ReloadAnims[i].SoundRef != "" )
            default.ReloadAnims[i].Sound = none;
    }

    return super.UnloadAssets();
}


simulated function PostNetReceive()
{
    super.PostNetReceive();

    if ( Role < ROLE_Authority ) {
        if ( OldMagAmmoRemaining != MagAmmoRemaining ) {
            if ( OldMagAmmoRemaining < MagAmmoRemaining ) {
                //just reloaded
                if ( IsInState('Reloading') )
                    GotoState('');
            }
            OldMagAmmoRemaining = MagAmmoRemaining;
        }
    }
}

simulated function HandleSleeveSwapping();



simulated function bool StartFire(int Mode)
{
    if( !super.StartFire(Mode) )  // returns false when mag is empty
       return false;

    if( AmmoAmount(Mode) <= 0 )
        return false;

    AnimStopLooping();

    if( !FireMode[Mode].IsInState('FireLoop') ) {
        FireMode[Mode].StartFiring();
        return true;
    }
    return false;
}




simulated function AnimEnd(int channel)
{
    local name anim;
    local float frame, rate;

    if( !FireMode[0].IsInState('FireLoop') && !FireMode[1].IsInState('FireLoop') )
    {
        GetAnimParams(0, anim, frame, rate);

        if (ClientState == WS_ReadyToFire)
        {
             if ((FireMode[0] == None || !FireMode[0].bIsFiring) && (FireMode[1] == None || !FireMode[1].bIsFiring))
            {
                PlayIdle();
            }
        }
    }
}


simulated function bool ConsumeAmmo( int Mode, float Load, optional bool bAmountNeededIsMax )
{
    local Inventory Inv;
    local bool bOutOfAmmo;
    local KFWeapon KFWeap;

    if ( Super(Weapon).ConsumeAmmo(Mode, Load, bAmountNeededIsMax) )
    {
        if ( Load > 0 && (Mode == 0 || bReduceMagAmmoOnSecondaryFire) ) {
            MagAmmoRemaining -= Load; // Changed from "MagAmmoRemaining--"  -- PooSH
            if ( MagAmmoRemaining < 0 )
                MagAmmoRemaining = 0;
        }
        OldMagAmmoRemaining = MagAmmoRemaining;

        NetUpdateTime = Level.TimeSeconds - 1;

        if ( FireMode[Mode].AmmoPerFire > 0 && InventoryGroup > 0 && !bMeleeWeapon && bConsumesPhysicalAmmo &&
             (Ammo[0] == none || FireMode[0] == none || FireMode[0].AmmoPerFire <= 0 || Ammo[0].AmmoAmount < FireMode[0].AmmoPerFire) &&
             (Ammo[1] == none || FireMode[1] == none || FireMode[1].AmmoPerFire <= 0 || Ammo[1].AmmoAmount < FireMode[1].AmmoPerFire) )
        {
            bOutOfAmmo = true;

            for ( Inv = Instigator.Inventory; Inv != none; Inv = Inv.Inventory )
            {
                KFWeap = KFWeapon(Inv);

                if ( Inv.InventoryGroup > 0 && KFWeap != none && !KFWeap.bMeleeWeapon && KFWeap.bConsumesPhysicalAmmo &&
                     ((KFWeap.Ammo[0] != none && KFWeap.FireMode[0] != none && KFWeap.FireMode[0].AmmoPerFire > 0 &&KFWeap.Ammo[0].AmmoAmount >= KFWeap.FireMode[0].AmmoPerFire) ||
                     (KFWeap.Ammo[1] != none && KFWeap.FireMode[1] != none && KFWeap.FireMode[1].AmmoPerFire > 0 && KFWeap.Ammo[1].AmmoAmount >= KFWeap.FireMode[1].AmmoPerFire)) )
                {
                    bOutOfAmmo = false;
                    break;
                }
            }

            if ( bOutOfAmmo )
            {
                PlayerController(Instigator.Controller).Speech('AUTO', 3, "");
            }
        }

        return true;
    }
    return false;
}


// since we don't have 'Tip' bone, need this hack
simulated function vector GetEffectStart()
{
    return super(Weapon).GetEffectStart();
}


simulated function ClientReload()
{
    super.ClientReload();

    GotoState('Reloading');
}


simulated state Reloading
{
    ignores PlayIdle;

    simulated function BeginState()
    {
        NextReloadAnimIndex = 0;
        NextReloadAnimTime = Level.TimeSeconds - 1; //play now

        if ( KFPlayerReplicationInfo(Instigator.PlayerReplicationInfo) != none && KFPlayerReplicationInfo(Instigator.PlayerReplicationInfo).ClientVeteranSkill != none )
            ReloadBonus = KFPlayerReplicationInfo(Instigator.PlayerReplicationInfo).ClientVeteranSkill.Static.GetReloadSpeedModifier(KFPlayerReplicationInfo(Instigator.PlayerReplicationInfo), self);
        else
            ReloadBonus = 1.0;
    }

    simulated function PlayNextSeq()
    {
        local AnimSeq seq;

        seq = ReloadAnims[NextReloadAnimIndex];
        if ( seq.AnimName != '' ) {
            PlayAnim(seq.AnimName, seq.AnimRateMult * ReloadAnimRate * ReloadBonus, seq.TweenTime);
            if ( seq.SkipFrames > 0 )
                SetAnimFrame(seq.SkipFrames, 0 , 1);
        }
        if ( seq.Sound !=  none ) {
            PlaySound(seq.Sound);
        }
        NextReloadAnimTime = Level.TimeSeconds + seq.Duration * ReloadAnimRate * ReloadBonus;
    }

    simulated function WeaponTick(float dt)
    {
        super.WeaponTick(dt);

        if ( !bIsReloading ) {
            GotoState('');
            return;
        }

        if ( NextReloadAnimTime <= Level.TimeSeconds && NextReloadAnimIndex < ReloadAnims.length ) {
            PlayNextSeq();
            NextReloadAnimIndex++;
        }
    }

    simulated function ActuallyFinishReloading()
    {
        global.ActuallyFinishReloading();
        GotoState('');
    }
}



defaultproperties
{
    // REF dynamic load model
    HudImageRef="HMG_T.Stinger.Unselected_Stinger"
    SelectedHudImageRef="HMG_T.Stinger.Selected_Stinger"
    SelectSoundRef="HMG_S.Stinger.StingerTakeOut"
    MeshRef="HMG_A.SK_WP_Stinger_1P"
    SkinRefs(0)="HMG_T.Stinger.StingerSkin"
    SkinRefs(1)="HMG_T.Stinger.T_WP_StingerCord_D"


    Weight=13
    IdleAimAnim="WeaponIdle"
    StandardDisplayFOV=55.000000
    bModeZeroCanDryFire=True
    TraderInfoTexture=Texture'HMG_T.Stinger.Trader_Stinger'
    PlayerIronSightFOV=65.000000
    ZoomedDisplayFOV=20.000000
    IdleAnim="WeaponIdle"
    PutDownAnim="WeaponPutDown"
    SelectForce="SwitchToAssaultRifle"
    AIRating=0.550000
    CurrentRating=0.550000
    bShowChargingBar=True
    Description="Stinger Minigun first was designed by Liandri corp. as a mining tool, but later converted into military service. Fires shards of unprocessed Tarydium crystal."
    DisplayFOV=55.000000
    CustomCrosshair=11
    CustomCrossHairTextureName="Crosshairs.HUD.Crosshair_Cross5"
    InventoryGroup=4
    GroupOffset=7
    PickupClass=class'StingerPickup'
    PlayerViewOffset=(X=50.000000,Y=-4.000000,Z=-4.000000)
    BobDamping=6.000000
    AttachmentClass=class'StingerAttachment'
    IconCoords=(X1=245,Y1=39,X2=329,Y2=79)



    // *** Modifications belowe made by [ScrN]PooSH ***
    ItemName="Stinger Minigun SE"
    FireModeClass(0)=class'StingerFire'
    FireModeClass(1)=class'StingerAltFire'

    bIsTier3Weapon=true
    Priority=140

    //TransientSoundVolume=1.250000 // adjusting volume can't make sound louder than default. But I agree that minigun has sound problems
    FlashBoneName="Stinger-TurretMini"
    SmallEffectOffset=(X=100.000000,Y=25.000000,Z=-5.000000) //offset from instigator's view location
    EffectOffset=(X=100.000000,Y=25.000000,Z=-5.000000) // this shouldn't be used

    MagCapacity=123 // 175
    ReloadRate=4.25 // should be a slightly less than a sum of all ReloadAnims.Duration
    ReloadAnim="" //use complex ReloadAnims instead
    ReloadAnimRate=1.0
    WeaponReloadAnim="Reload_AA12" // this animation belongs to Pawn, not the Weapon
    ReloadAnims(0)=(AnimName="WeaponRampDown",AnimRateMult=4.0,TweenTime=0.01,Duration=0.5,SoundRef="HMG_S.Stinger.StingerRapidStop")   // 30 frames
    // Animation Duration=1.916667
    ReloadAnims(1)=(AnimName="WeaponPutDown",AnimRateMult=0.6,TweenTime=0.01,Duration=0.816667)    // 23 frames
    ReloadAnims(2)=(SoundRef="KF_AA12Snd.AA12_Reload_011",Duration=0.5) // sound only, WeaponPutDown still is playing
    ReloadAnims(3)=(SoundRef="KF_M32Snd.M32_Reload_000",Duration=0.5) // sound only, WeaponPutDown still is playing
    ReloadAnims(4)=(SoundRef="KF_M32Snd.M32_Reload_280",Duration=0.6)
    ReloadAnims(5)=(AnimName="WeaponEquip",AnimRateMult=0.8,TweenTime=0.1,Duration=0.933333,SoundRef="HMG_S.Stinger.StingerTakeOut") // 35 frames
    ReloadAnims(6)=(AnimName="WeaponRampDown",AnimRateMult=4.0,Duration=0.5,SoundRef="HMG_S.Stinger.StingerRapidStop")   // 30 frames
    // ANNOYING SOUND: HMG_S.Stinger.StingerRapidStop
}
