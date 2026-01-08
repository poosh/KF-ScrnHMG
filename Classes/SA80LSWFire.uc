//=============================================================================
 //L86A1 Fire
//=============================================================================
class SA80LSWFire extends ScrnFire;

defaultproperties
{
    // FireSound=Sound'HMG_S.SA80.SA80LSW_shot'
    // StereoFireSound=Sound'HMG_S.SA80.SA80LSW_shot'
    // NoAmmoSound=Sound'HMG_S.SA80.SA80LSW_empty'

    FireSoundRef="HMG_S.SA80.SA80LSW_shot"
    StereoFireSoundRef="HMG_S.SA80.SA80LSW_shot"
    NoAmmoSoundRef="HMG_S.SA80.SA80LSW_empty"

    FireAimedAnim="Iron_Idle"
    RecoilRate=0.050000
    maxVerticalRecoilAngle=300
    maxHorizontalRecoilAngle=100
    ShellEjectClass=Class'ROEffects.KFShellEjectBullpup'
    ShellEjectBoneName="Shell_eject"
    DamageType=class'DamTypeSA80LSW'
    DamageMin=42
    DamageMax=42
    Momentum=12500.000000
    bPawnRapidFireAnim=True
    TransientSoundVolume=1.800000
    FireLoopAnim="Fire"
    TweenTime=0.025000
    FireForce="AssaultRifleFire"
    FireRate=0.100000
    AmmoClass=class'SA80LSWAmmo'
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
    Spread=0.008500
    SpreadStyle=SS_Random
    bAccuracyBonusForSemiAuto=True
    MaxSpreadBurst=10
    MaxSpread=0.20
    SpreadCrouchMod=0.25
}
