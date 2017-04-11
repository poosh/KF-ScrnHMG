class RPK47Fire extends KFFire;

defaultproperties
{
     FireSoundRef="HMG_S.RPK.rpk47_shoot"
     StereoFireSoundRef="HMG_S.RPK.rpk47_shoot"
     NoAmmoSoundRef="HMG_S.RPK.rpk47_empty"

     FireAimedAnim="Fire_Iron"
     RecoilRate=0.050000
     maxVerticalRecoilAngle=600
     maxHorizontalRecoilAngle=300
     bRecoilRightOnly=True
     ShellEjectClass=Class'ROEffects.KFShellEjectAK'
     ShellEjectBoneName="Shell_eject"
     bAccuracyBonusForSemiAuto=True
     bRandomPitchFireSound=False
     DamageType=Class'ScrnHMG.DamTypeRPK47MG'
     DamageMin=45
     DamageMax=63
     Momentum=10500.000000
     bPawnRapidFireAnim=True
     TransientSoundVolume=3.800000
     FireLoopAnim="Fire"
     TweenTime=0.025000
     FireForce="AssaultRifleFire"
     FireRate=0.109000
     AmmoClass=Class'ScrnHMG.RPK47Ammo'
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
