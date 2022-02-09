//=============================================================================
 //SCARMK17 Fire
//=============================================================================
class M41AFire extends KFFire;



defaultproperties
{
     FireSoundRef="HMG_S.M41A.M41AFireMono"
     StereoFireSoundRef="HMG_S.M41A.M41AFire"
     NoAmmoSoundRef="HMG_S.M41A.DryFire"

     FireAimedAnim="Fire_Iron"
     RecoilRate=0.050000 // 0.04
     maxVerticalRecoilAngle=100 // 50 
     maxHorizontalRecoilAngle=80 // 80
     ShellEjectClass=Class'ROEffects.KFShellEjectSCAR'
     ShellEjectBoneName="Shell Feeder"
     DamageType=class'DamTypeM41AAssaultRifle'
     DamageMin=68
     DamageMax=82 // 88
     Momentum=13500.000000
     bPawnRapidFireAnim=True
     TransientSoundVolume=5.800000
     FireLoopAnim="Fire"
     TweenTime=0.025000
     FireForce="AssaultRifleFire"
     FireRate=0.070000
     AmmoClass=class'M41AAmmo'
     AmmoPerFire=1
     ShakeRotMag=(X=50.000000,Y=50.000000,Z=300.000000)
     ShakeRotRate=(X=7500.000000,Y=7500.000000,Z=7500.000000)
     ShakeRotTime=0.650000
     ShakeOffsetMag=(X=6.000000,Y=3.000000,Z=7.500000)
     ShakeOffsetRate=(X=1000.000000,Y=1000.000000,Z=1000.000000)
     ShakeOffsetTime=1.150000
     BotRefireRate=0.990000
     FlashEmitterClass=class'MuzzleFlashM41A'
     aimerror=42.000000
     Spread=0.009 // 0.0075
     SpreadStyle=SS_Random
}
