class PKMFire extends ScrnFire;

defaultproperties
{
     FireSoundRef="HMG_S.PKM.pkm_shoot_mono"
     StereoFireSoundRef="HMG_S.PKM.pkm_shoot_stereo"
     NoAmmoSoundRef="HMG_S.PKM.pkm_empty"

     FireAimedAnim="Fire"
     RecoilRate=0.055000
     maxVerticalRecoilAngle=600
     maxHorizontalRecoilAngle=250
     bRecoilRightOnly=True
     ShellEjectClass=Class'ScrnHMG.KFShellEjectPKM'
     ShellEjectBoneName="shell_13"
     bAccuracyBonusForSemiAuto=True
     bRandomPitchFireSound=False
     DamageType=Class'ScrnHMG.DamTypePKM'
     DamageMin=68  // deprecated
     DamageMax=68
     PenDmgReduction=0.35
     MaxPenetrations=1
     Momentum=10900.000000
     bPawnRapidFireAnim=True
     TransientSoundVolume=3.000000
     FireLoopAnim="Fire"
     TweenTime=0.025000
     FireForce="AssaultRifleFire"
     FireRate=0.095000
     AmmoClass=Class'ScrnHMG.PKMAmmo'
     AmmoPerFire=1
     ShakeRotMag=(X=50.000000,Y=50.000000,Z=350.000000)
     ShakeRotRate=(X=5000.000000,Y=5000.000000,Z=5000.000000)
     ShakeRotTime=0.750000
     ShakeOffsetMag=(X=6.000000,Y=3.000000,Z=7.500000)
     ShakeOffsetRate=(X=1000.000000,Y=1000.000000,Z=1000.000000)
     ShakeOffsetTime=1.250000
     BotRefireRate=0.990000
     FlashEmitterClass=Class'ScrnHMG.MuzzleFlash1stPKM'
     aimerror=42.000000
     Spread=0.030000
     SpreadStyle=SS_Random
}
