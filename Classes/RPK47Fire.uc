class RPK47Fire extends ScrnFire;

var float SemiPenDmgReduction; // PenDmgReduction in semi-auto mode
var float SemiPenDmgReductionByHealth; // PenDmgReduction in semi-auto mode


function FireModeChanged()
{
    if (bWaitForRelease) {
        PenDmgReduction = SemiPenDmgReduction;
        PenDmgReductionByHealth = SemiPenDmgReductionByHealth;
    }
    else {
        PenDmgReduction = default.PenDmgReduction;
        PenDmgReductionByHealth = default.PenDmgReductionByHealth;
    }
}


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
     DamageType=class'DamTypeRPK47MG'

     DamageMin=20  // stop penetration if damage drops below 20
     DamageMax=58  // the original damage (before perk bonus)
     PenDmgReduction=0.80  // 20% damage drop on penetration
     PenDmgReductionByHealth=0.0002  // 2% damage drop per 100hp
     SemiPenDmgReduction=0.90
     SemiPenDmgReductionByHealth=0.0001
     MaxPenetrations=10
     Momentum=10500

     bPawnRapidFireAnim=True
     TransientSoundVolume=3.800000
     FireLoopAnim="Fire"
     TweenTime=0.025000
     FireForce="AssaultRifleFire"
     FireRate=0.109000
     AmmoClass=class'RPK47Ammo'
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
