class StingerFire extends ScrnHighROFFire;


//overrided to disable FlashEmitter attaching to Stinger
simulated function InitEffects()
{
    super(InstantFire).InitEffects();

    // For some reason, AmbientFireSound gets loaded in PreloadAssets(), but then reset back to none
    AmbientFireSound = default.AmbientFireSound;

    // don't even spawn on server
    if ( (Level.NetMode == NM_DedicatedServer) || (AIController(Instigator.Controller) != None) )
        return;

    if ( (ShellEjectClass != None) && ((ShellEjectEmitter == None) || ShellEjectEmitter.bDeleteMe) )
    {
        ShellEjectEmitter = Weapon.Spawn(ShellEjectClass);
        Weapon.AttachToBone(ShellEjectEmitter, ShellEjectBoneName);
    }

    // if ( FlashEmitter != None ) {
        // Weapon.AttachToBone(FlashEmitter, KFWeapon(Weapon).FlashBoneName);
    // }
}


defaultproperties
{
    // REF dynamic load model
    AmbientFireSoundRef="HMG_S.Stinger.StingerPrimaryAmb"
    // StingerRapidStop is too annoying. Replaced with Pat's sound
    // FireEndSoundRef="HMG_S.Stinger.StingerRapidStop"
    FireEndSoundRef="KF_BasePatriarch.Attack.Kev_MG_TurbineWindDown"
    NoAmmoSoundRef="HMG_S.M41A.DryFire"

    RecoilRate=0.012500
    maxVerticalRecoilAngle=65
    maxHorizontalRecoilAngle=65
    RecoilVelocityScale=0
    ShellEjectClass=Class'ROEffects.KFShellEjectSCAR'
    ShellEjectBoneName="Stinger-CordFlap"
    DamageType=class'DamTypeStinger'
    Momentum=8500.000000
    PreFireAnim="WeaponFireStart"
    FireLoopAnim="WeaponFire"
    FireEndAnim="WeaponFireEnd"
    AmmoClass=class'StingerAmmo'
    ShakeRotMag=(X=50.000000,Y=50.000000,Z=300.000000)
    ShakeRotRate=(X=7500.000000,Y=7500.000000,Z=7500.000000)
    ShakeRotTime=0.650000
    ShakeOffsetMag=(X=6.000000,Y=3.000000,Z=7.500000)
    ShakeOffsetRate=(X=1000.000000,Y=1000.000000,Z=1000.000000)
    ShakeOffsetTime=1.150000
    BotRefireRate=0.59
    FlashEmitterClass=class'StingerMuzzleFlash1st'
    bAttachFlashEmitter=false
    aimerror=42.000000
    Spread=0.217500
    SpreadStyle=SS_Random
    MaxSpreadBurst=25
    MaxSpread=0.50
    SpreadCrouchMod=0.5


    //TransientSoundVolume=4.8 // adjusting volume can't make sound louder, only softer.
    DamageMin=35
    DamageMax=35
    FireRate=0.033 // 1800 RPM
    FireLoopAnimRate=1.35

    AmbientFireVolume=255
    AmbientFireSoundRadius=500
}
