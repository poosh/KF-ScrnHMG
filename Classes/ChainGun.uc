//=============================================================================
// HuskGun
//=============================================================================
// Husk Arm fireball launching gun
//=============================================================================
// Killing Floor Source
// Copyright (C) 2011 Tripwire Interactive LLC
// - John "Ramm-Jaeger" Gibson
//=============================================================================
class ChainGun extends KFWeapon;

simulated function bool StartFire(int Mode)
{
    if( Mode == 1 )
        return super.StartFire(Mode);

    if( !super.StartFire(Mode) )  // returns false when mag is empty
       return false;

    if( AmmoAmount(0) <= 0 )
    {
        return false;
    }

    AnimStopLooping();

    if( !FireMode[Mode].IsInState('FireLoop') && (AmmoAmount(0) > 0) )
    {
        FireMode[Mode].StartFiring();
        return true;
    }
    else
    {
        return false;
    }

    return true;
}

simulated function AnimEnd(int channel)
{
    local name anim;
    local float frame, rate;

    if(!FireMode[0].IsInState('FireLoop'))
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

simulated event OnZoomOutFinished()
{
    local name anim;
    local float frame, rate;

    GetAnimParams(0, anim, frame, rate);

    if (ClientState == WS_ReadyToFire)
    {
        // Play the regular idle anim when we're finished zooming out
        if (anim == IdleAimAnim)
        {
            PlayIdle();
        }
        // Switch looping fire anims if we switched to/from zoomed
        else if( FireMode[0].IsInState('FireLoop') && anim == 'Fire_Iron_Loop')
        {
            LoopAnim('Fire_Loop', FireMode[0].FireLoopAnimRate, FireMode[0].TweenTime);
        }
    }
}

/**
 * Called by the native code when the interpolation of the first person weapon to the zoomed position finishes
 */
simulated event OnZoomInFinished()
{
    local name anim;
    local float frame, rate;

    GetAnimParams(0, anim, frame, rate);

    if (ClientState == WS_ReadyToFire)
    {
        // Play the iron idle anim when we're finished zooming in
        if (anim == IdleAnim)
        {
           PlayIdle();
        }
        // Switch looping fire anims if we switched to/from zoomed
        else if( FireMode[0].IsInState('FireLoop') && anim == 'Fire_Loop' )
        {
            LoopAnim('Fire_Iron_Loop', FireMode[0].FireLoopAnimRate, FireMode[0].TweenTime);
        }
    }
}
// Don't use alt fire to toggle
simulated function AltFire(float F){}
// Don't switch fire mode
exec function SwitchModes(){}

defaultproperties
{
     // Mesh=SkeletalMesh'HMG_A.PatGunMesh'
     // Skins(0)=Combiner'KF_Weapons4_Trip_T.Weapons.HUSK_cmb'
     // Skins(1)=Combiner'KF_Weapons_Trip_T.hands.hands_1stP_military_cmb'
     // Skins(2)=Combiner'KF_Specimens_Trip_T.gatling_cmb'
     // Skins(3)=Texture'HMG_A.Handle'
     // HudImage=Texture'HMG_A.patgun_unselected'
     // SelectedHudImage=Texture'HMG_A.patgun_selected'

     MeshRef="HMG_A.PatGunMesh"
     SkinRefs(0)="KF_Weapons4_Trip_T.Weapons.HUSK_cmb"
     SkinRefs(1)="KF_Weapons_Trip_T.hands.hands_1stP_military_cmb"
     SkinRefs(2)="KF_Specimens_Trip_T.gatling_cmb"
     SkinRefs(3)="HMG_T.PatGun.Handle"
     HudImageRef="HMG_T.PatGun.patgun_unselected"
     SelectedHudImageRef="HMG_T.patgun_selected"
     SelectSoundRef="HMG_S.Stinger.StingerTakeOut"

     bIsTier3Weapon=True
     MagCapacity=150
     ReloadRate=6.5
     bHasSecondaryAmmo=True
     ReloadAnim="CrappyReload"
     ReloadAnimRate=1.0
     WeaponReloadAnim="Reload_AA12"
     Weight=17.000000
     IdleAimAnim="Idle"
     StandardDisplayFOV=55.000000
     bModeZeroCanDryFire=True
     TraderInfoTexture=Texture'HMG_T.PatGun.patgun_unselected'
     PlayerIronSightFOV=65.000000
     ZoomedDisplayFOV=45.000000
     FireModeClass(0)=class'ChainGunFire'
     FireModeClass(1)=class'ChainGunAltFire'
     PutDownAnim="PutDown"
     SelectForce="SwitchToAssaultRifle"
     AIRating=0.550000
     CurrentRating=0.550000
     Description="Chaingun ripped from dead Patriarch's hand. Or maybe ripped WITH. Or even WITH ALIVE. It works and nothing else matters."
     EffectOffset=(X=100.000000,Y=25.000000,Z=-10.000000)
     DisplayFOV=55.000000
     Priority=155
     InventoryGroup=4
     GroupOffset=5
     PickupClass=class'ChainGunPickup'
     PlayerViewOffset=(X=40.000000,Y=40.000000,Z=16.000000)
     BobDamping=6.000000
     AttachmentClass=class'ChainGunAttachment'
     IconCoords=(X1=245,Y1=39,X2=329,Y2=79)
     ItemName="Patriarch's Chaingun SE"
     TransientSoundVolume=1.250000
}
