class ThompsonHFire extends KFFire;

defaultproperties
{
     FireSoundRef="KF_IJC_HalloweenSnd.Thompson_Fire_Single_M"
     StereoFireSoundRef="KF_IJC_HalloweenSnd.Thompson_Fire_Single_S"
     NoAmmoSoundRef="KF_AK47Snd.AK47_DryFire"

     FireAimedAnim="Fire"
     RecoilRate=0.010000
     maxVerticalRecoilAngle=50
     maxHorizontalRecoilAngle=20
     bRecoilRightOnly=True
     ShellEjectClass=Class'ROEffects.KFShellEjectMP5SMG'
     ShellEjectBoneName="Shell_eject"
     bAccuracyBonusForSemiAuto=True
     bRandomPitchFireSound=False
     DamageType=Class'ScrnHMG.DamTypeThompsonH'
     DamageMin=40
     DamageMax=41
     Momentum=7500.000000
     bPawnRapidFireAnim=True
     TransientSoundVolume=1.800000
     FireLoopAnim="Fire"
     TweenTime=0.025000
     FireForce="AssaultRifleFire"
     FireRate=0.079000
     AmmoClass=Class'ScrnHMG.ThompsonHAmmo'
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