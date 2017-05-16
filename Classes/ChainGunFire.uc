class ChainGunFire extends KFHighROFFire;

defaultproperties
{
     FireEndSoundRef="KF_BasePatriarch.Attack.Kev_MG_TurbineWindDown"
     AmbientFireSoundRef="KF_BasePatriarch.Attack.Kev_MG_GunfireLoop"

     RecoilRate=0.005000
     maxVerticalRecoilAngle=20
     maxHorizontalRecoilAngle=15
     RecoilVelocityScale=0.000000
     ShellEjectClass=Class'ScrnHMG.CGShellEject'
     ShellEjectBoneName="Barrel"
     DamageType=Class'ScrnHMG.DamTypeCG'
     DamageMin=60 // deprecated
     DamageMax=60 // 100
     Momentum=15000.000000
     FireLoopAnim="FireLoop"
     FireEndAnim="FireLoopEnd"
     FireRate=0.08 // 0.12
     FireAnimRate=1.5
     AmmoClass=Class'ScrnHMG.ChainGunAmmo'
     ShakeRotMag=(X=25.000000,Y=25.000000,Z=125.000000)
     ShakeRotRate=(X=10000.000000,Y=10000.000000,Z=10000.000000)
     ShakeRotTime=3.000000
     ShakeOffsetMag=(X=4.000000,Y=2.500000,Z=5.000000)
     ShakeOffsetRate=(X=1000.000000,Y=1000.000000,Z=1000.000000)
     ShakeOffsetTime=1.250000
     FlashEmitterClass=Class'ROEffects.MuzzleFlash1stMG'
     Spread=0.200000 //0.1
     SpreadStyle=SS_Random
}
