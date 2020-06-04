class StingerAltFire extends KFFire;


//overrided to disable FlashEmitter attaching to Stinger
simulated function InitEffects()
{
    super(InstantFire).InitEffects();

    // don't even spawn on server
    if ( (Level.NetMode == NM_DedicatedServer) || (AIController(Instigator.Controller) != None) )
        return;

    if ( (ShellEjectClass != None) && ((ShellEjectEmitter == None) || ShellEjectEmitter.bDeleteMe) )
    {
        ShellEjectEmitter = Weapon.Spawn(ShellEjectClass);
        Weapon.AttachToBone(ShellEjectEmitter, ShellEjectBoneName);
    }

    // if ( FlashEmitter != None )
        // Weapon.AttachToBone(FlashEmitter, KFWeapon(Weapon).FlashBoneName);
}


defaultproperties
{
    // FireSoundRef="HMG_S.Stinger.StingerAltStop"
    FireSoundRef="HMG_S.Stinger.StingerHitEnemy"
    NoAmmoSoundRef="KF_SCARSnd.SCAR_DryFire"

    RecoilRate=0.075
    maxVerticalRecoilAngle=500
    maxHorizontalRecoilAngle=250
    ShellEjectClass=Class'ROEffects.KFShellEjectSCAR'
    ShellEjectBoneName="Stinger-CordFlap"
    DamageType=Class'ScrnHMG.DamTypeStingerAlt'
    DamageMin=139
    DamageMax=139
    Momentum=25500.000000
    FireAnim="WeaponFire-Secondary"
    FireLoopAnim="WeaponFire-Secondary"
    FireEndAnim="WeaponFireEnd"
    FireRate=0.566667
    // FireLoopAnimRate=2.0
    AmmoClass=Class'ScrnHMG.StingerAmmo'
    ShakeRotMag=(X=50.000000,Y=50.000000,Z=300.000000)
    ShakeRotRate=(X=7500.000000,Y=7500.000000,Z=7500.000000)
    ShakeRotTime=0.650000
    ShakeOffsetMag=(X=6.000000,Y=3.000000,Z=7.500000)
    ShakeOffsetRate=(X=1000.000000,Y=1000.000000,Z=1000.000000)
    ShakeOffsetTime=1.150000
    BotRefireRate=0.990000
    FlashEmitterClass=Class'ScrnHMG.StingerMuzzleFlash1st'
    aimerror=30.000000
    Spread=0.02
    SpreadStyle=SS_Random
    AmmoPerFire=3
    TransientSoundVolume=1.0
}
