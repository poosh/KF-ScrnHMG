class StingerFire extends KFHighROFFire;

var transient float FireRateReminder;

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

    // if ( FlashEmitter != None ) {
        // Weapon.AttachToBone(FlashEmitter, KFWeapon(Weapon).FlashBoneName);
    // }
}

event ModeDoFire()
{
    if ( Level.TimeSeconds - LastFireTime > 0.1 )
        FireRateReminder = 0;
    else
        FireRateReminder += fmax(Level.TimeSeconds - FireRate - LastFireTime, 0.f); // do precise fire rate
    
    super.ModeDoFire();
    
    if ( FireRateReminder > 0 ) {
        NextFireTime -= FireRateReminder;
        if ( NextFireTime < Level.TimeSeconds ) {
            FireRateReminder = Level.TimeSeconds - NextFireTime;
            NextFireTime = Level.TimeSeconds;
        }
    }
}

// simulated function HandleRecoil(float Rec)
// {
    // if ( FireRateReminder > 0.15 )
        // return; // additional shots
    
    // super.HandleRecoil(Rec);
// }


defaultproperties
{
     // AmbientFireSound=Sound'HMG_S.Stinger.StingerPrimaryAmb'
     // FireEndSound=Sound'HMG_S.Stinger.StingerRapidStop'
     // NoAmmoSound=Sound'KF_SCARSnd.SCAR_DryFire'     
     
     // REF dynamic load model
     AmbientFireSoundRef="HMG_S.Stinger.StingerPrimaryAmb"
     //FireEndSoundRef="HMG_S.Stinger.StingerRapidStop"
     FireEndSoundRef="KF_BasePatriarch.Attack.Kev_MG_TurbineWindDown"
     NoAmmoSoundRef="HMG_S.M41A.DryFire"

     RecoilRate=0.012500
     maxVerticalRecoilAngle=65
     maxHorizontalRecoilAngle=65
     RecoilVelocityScale=0
     ShellEjectClass=Class'ROEffects.KFShellEjectSCAR'
     ShellEjectBoneName="Stinger-CordFlap"
     DamageType=Class'ScrnHMG.DamTypeStinger'
     DamageMin=35
     Momentum=8500.000000
     PreFireAnim="WeaponFireStart"
     FireLoopAnim="WeaponFire"
     FireEndAnim="WeaponFireEnd"
     AmmoClass=Class'ScrnHMG.StingerAmmo'
     ShakeRotMag=(X=50.000000,Y=50.000000,Z=300.000000)
     ShakeRotRate=(X=7500.000000,Y=7500.000000,Z=7500.000000)
     ShakeRotTime=0.650000
     ShakeOffsetMag=(X=6.000000,Y=3.000000,Z=7.500000)
     ShakeOffsetRate=(X=1000.000000,Y=1000.000000,Z=1000.000000)
     ShakeOffsetTime=1.150000
     BotRefireRate=0.59
     FlashEmitterClass=Class'ROEffects.MuzzleFlash1stSPSniper'
     bAttachFlashEmitter=false
     aimerror=42.000000
     Spread=0.217500
     SpreadStyle=SS_Random
     
     
     // *** Modifications belowe made by [ScrN]PooSH ***
     
     //TransientSoundVolume=4.8 // adjusting volume can't make sound louder, only softer. But I agree that minigun has sound problems
     DamageMax=35 //50
     FireRate=0.03 // 2000 RPM
     FireLoopAnimRate=1.5 //1.0
     
     AmbientFireSoundRadius=500
}
