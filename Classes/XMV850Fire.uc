class XMV850Fire extends ScrnFire;

defaultproperties
{
     FireSoundRef="HMG_S.XMV.XMV-Fire-1"
     StereoFireSoundRef="HMG_S.XMV.XMV-Fire-1"
     NoAmmoSoundRef="HMG_S.M41A.DryFire"

     FireAnim="FireLoop"
     FireAimedAnim="FireLoop"
     RecoilRate=0.040000
     maxVerticalRecoilAngle=150
     maxHorizontalRecoilAngle=125
     ShellEjectClass=Class'ROEffects.KFShellEjectSCAR'
     ShellEjectBoneName="ejector"
     DamageType=class'DamTypeXMV850M'
     DamageMin=45
     DamageMax=45
     FireRate=0.065 // 0.076000
     Momentum=8500.000000
     bPawnRapidFireAnim=True
     TransientSoundVolume=4.800000
     TweenTime=0.025000
     FireForce="AssaultRifleFire"
     AmmoClass=class'XMV850Ammo'
     AmmoPerFire=1
     ShakeRotMag=(X=50.000000,Y=50.000000,Z=300.000000)
     ShakeRotRate=(X=7500.000000,Y=7500.000000,Z=7500.000000)
     ShakeRotTime=0.650000
     ShakeOffsetMag=(X=6.000000,Y=3.000000,Z=7.500000)
     ShakeOffsetRate=(X=1000.000000,Y=1000.000000,Z=1000.000000)
     ShakeOffsetTime=1.150000
     BotRefireRate=0.990000
     FlashEmitterClass=Class'ROEffects.MuzzleFlash1stSTG'
     aimerror=42.000000
     Spread=0.010
     SpreadStyle=SS_Random
     MaxSpreadBurst=15
     MaxSpread=0.30
     SpreadCrouchMod=0.5
}
