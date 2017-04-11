//=============================================================================
 //AUG A1 Fire
//=============================================================================
class AUG_A1ARFire extends KFFire;

defaultproperties
{
     FireSoundRef="HMG_S.AUGND.aug_fire"
     StereoFireSoundRef="HMG_S.AUGND.aug_fire"
     NoAmmoSoundRef="HMG_S.AUGND.aug_empty"

     FireAimedAnim="Idle_Iron"
     RecoilRate=0.080000
     maxVerticalRecoilAngle=500
     maxHorizontalRecoilAngle=250
     ShellEjectClass=Class'ROEffects.KFShellEjectBullpup'
     ShellEjectBoneName="Shell_eject"
     bAccuracyBonusForSemiAuto=True
     DamageType=Class'ScrnHMG.DamTypeAUG_A1AR'
     DamageMin=40
     DamageMax=50
     Momentum=12000.000000
     bPawnRapidFireAnim=True
     TransientSoundVolume=1.800000
     FireLoopAnim="Fire"
     TweenTime=0.025000
     FireForce="AssaultRifleFire"
     FireRate=0.120000
     AmmoClass=Class'ScrnHMG.AUG_A1ARAmmo'
     AmmoPerFire=1
     ShakeRotMag=(X=75.000000,Y=75.000000,Z=250.000000)
     ShakeRotRate=(X=10000.000000,Y=10000.000000,Z=10000.000000)
     ShakeRotTime=0.500000
     ShakeOffsetMag=(X=6.000000,Y=3.000000,Z=10.000000)
     ShakeOffsetRate=(X=1000.000000,Y=1000.000000,Z=1000.000000)
     ShakeOffsetTime=1.000000
     BotRefireRate=0.990000
     FlashEmitterClass=Class'ROEffects.MuzzleFlash1stSTG'
     aimerror=42.000000
     Spread=0.005500
     SpreadStyle=SS_Random
}
