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
     ShellEjectClass=class'KFShellEjectPKM'
     ShellEjectBoneName="shell_13"
     bAccuracyBonusForSemiAuto=True
     bRandomPitchFireSound=False
     DamageType=class'DamTypePKM'

     DamageMin=20  // stop penetration if damage drops below 20
     DamageMax=68  // the original damage (before perk bonus)
     PenDmgReduction=0.65  // 35% damage drop on penetration
     PenDmgReductionByHealth=0.00005  // 5% damage drop per 1000hp
     MaxPenetrations=5
     Momentum=15000

     bPawnRapidFireAnim=True
     TransientSoundVolume=3.000000
     FireLoopAnim="Fire"
     TweenTime=0.025000
     FireForce="AssaultRifleFire"
     FireRate=0.095000
     AmmoClass=class'PKMAmmo'
     AmmoPerFire=1
     ShakeRotMag=(X=50.000000,Y=50.000000,Z=350.000000)
     ShakeRotRate=(X=5000.000000,Y=5000.000000,Z=5000.000000)
     ShakeRotTime=0.750000
     ShakeOffsetMag=(X=6.000000,Y=3.000000,Z=7.500000)
     ShakeOffsetRate=(X=1000.000000,Y=1000.000000,Z=1000.000000)
     ShakeOffsetTime=1.250000
     BotRefireRate=0.990000
     FlashEmitterClass=class'MuzzleFlash1stPKM'
     aimerror=42.000000
     Spread=0.030000
     SpreadStyle=SS_Random
     MaxSpreadBurst=20
     MaxSpread=0.40
     SpreadCrouchMod=0.60
     SpreadAimMod=0.70
}
