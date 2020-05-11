class M249Fire extends ScrnFire;

defaultproperties
{
     FireSoundRef="HMG_S.M249.m249_shoot_mono"
     StereoFireSoundRef="HMG_S.M249.m249_shoot_stereo"
     NoAmmoSoundRef="HMG_S.M249.m249_empty"

     FireAimedAnim="Fire"
     RecoilRate=0.040000
     maxVerticalRecoilAngle=500 //350
     maxHorizontalRecoilAngle=250 //250
     bRecoilRightOnly=True
     ShellEjectClass=Class'ROEffects.KFShellEjectAK'
     ShellEjectBoneName="Shell_eject"
     bAccuracyBonusForSemiAuto=True
     bRandomPitchFireSound=False
     DamageType=Class'ScrnHMG.DamTypeM249SAW'
     DamageMin=79  // deprecated
     DamageMax=79 // down from 85
     PenDmgReduction=0.35
     MaxPenetrations=1
     Momentum=12500.000000
     bPawnRapidFireAnim=True
     TransientSoundVolume=1.800000
     FireLoopAnim="Fire"
     TweenTime=0.025000
     FireForce="AssaultRifleFire"
     FireRate=0.109000
     AmmoClass=Class'ScrnHMG.M249Ammo'
     AmmoPerFire=1
     ShakeRotMag=(X=50.000000,Y=50.000000,Z=350.000000)
     ShakeRotRate=(X=5000.000000,Y=5000.000000,Z=5000.000000)
     ShakeRotTime=0.750000
     ShakeOffsetMag=(X=6.000000,Y=3.000000,Z=7.500000)
     ShakeOffsetRate=(X=1000.000000,Y=1000.000000,Z=1000.000000)
     ShakeOffsetTime=1.250000
     BotRefireRate=0.990000
     FlashEmitterClass=Class'ROEffects.MuzzleFlash1stMP'
     aimerror=42.000000
     Spread=0.015000
     SpreadStyle=SS_Random
}
