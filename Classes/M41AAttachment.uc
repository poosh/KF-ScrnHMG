class M41AAttachment extends ScrnLaserWeaponAttachment;

defaultproperties
{
    // the original model crashes other players that look at it, so we use M4M203 as a placeholder
    // MeshRef="HMG_A.M41APulseRifle3RD"
    // LaserAttachmentBone="FlashLight"
    // ShellEjectBoneName="ShellPort"

    MeshRef="KF_Weapons3rd3_Trip.M4M203_3rd"
    LaserAttachmentBone="tip"
    ShellEjectBoneName="Shell_eject"

    mMuzFlashClass=Class'ROEffects.MuzzleFlash3rdMP'
    mShellCaseEmitterClass=Class'KFMod.KFShellSpewer'
    mTracerClass=Class'KFMod.KFNewTracer'
    SplashEffect=Class'ROEffects.BulletSplashEmitter'
    bRapidFire=True
    bAltRapidFire=False
    CullDistance=5000.000000

    MovementAnims(0)="JogF_M4203"
    MovementAnims(1)="JogB_M4203"
    MovementAnims(2)="JogL_M4203"
    MovementAnims(3)="JogR_M4203"
    TurnLeftAnim="TurnL_M4203"
    TurnRightAnim="TurnR_M4203"
    CrouchAnims(0)="CHWalkF_M4203"
    CrouchAnims(1)="CHWalkB_M4203"
    CrouchAnims(2)="CHWalkL_M4203"
    CrouchAnims(3)="CHWalkR_M4203"
    WalkAnims(0)="WalkF_M4203"
    WalkAnims(1)="WalkB_M4203"
    WalkAnims(2)="WalkL_M4203"
    WalkAnims(3)="WalkR_M4203"
    CrouchTurnRightAnim="CH_TurnR_M4203"
    CrouchTurnLeftAnim="CH_TurnL_M4203"
    IdleCrouchAnim="CHIdle_M4203"
    IdleWeaponAnim="Idle_M4203"
    IdleRestAnim="Idle_M4203"
    IdleChatAnim="Idle_M4203"
    IdleHeavyAnim="Idle_M4203"
    IdleRifleAnim="Idle_M4203"
    FireAnims(0)="Fire_M4203"
    FireAnims(1)="Fire_M4203"
    FireAnims(2)="Fire_M4203"
    FireAnims(3)="Fire_M4203"
    FireAltAnims(0)="Reload_Secondary_M4203"
    FireAltAnims(1)="Reload_Secondary_M4203"
    FireAltAnims(2)="Reload_Secondary_M4203"
    FireAltAnims(3)="Reload_Secondary_M4203"
    FireCrouchAnims(0)="CHFire_M4203"
    FireCrouchAnims(1)="CHFire_M4203"
    FireCrouchAnims(2)="CHFire_M4203"
    FireCrouchAnims(3)="CHFire_M4203"
    FireCrouchAltAnims(0)="Reload_Secondary_M4203"
    FireCrouchAltAnims(1)="Reload_Secondary_M4203"
    FireCrouchAltAnims(2)="Reload_Secondary_M4203"
    FireCrouchAltAnims(3)="Reload_Secondary_M4203"
    HitAnims(0)="HitF_M4203"
    HitAnims(1)="HitB_M4203"
    HitAnims(2)="HitL_M4203"
    HitAnims(3)="HitR_M4203"
    PostFireBlendStandAnim="Blend_M4203"
    PostFireBlendCrouchAnim="CHBlend_M4203"
}
