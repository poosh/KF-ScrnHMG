class StingerAttachment extends KFWeaponAttachment;

var vector FlashOffset;
var rotator FlashRotationOffset;

simulated function DoFlashEmitter()
{
    if ( !Instigator.IsFirstPerson() ) {
        if (mMuzFlash3rd == None )
        {
            mMuzFlash3rd = Spawn(mMuzFlashClass);
            AttachToBone(mMuzFlash3rd, 'b_gun_barrel');
            mMuzFlash3rd.SetRelativeRotation(FlashRotationOffset);
            mMuzFlash3rd.SetRelativeLocation(FlashOffset);
        }

        if(mMuzFlash3rd != None)
            mMuzFlash3rd.SpawnParticle(1);
    }
}

//overrider to enable ROBulletHitEffect on both fire modes -- PooSH
simulated event ThirdPersonEffects()
{
	local PlayerController PC;

	if ( (Level.NetMode == NM_DedicatedServer) || (Instigator == None) )
		return;

	// new Trace FX - Ramm
	// if (FiringMode == 0)
	// {
		if ( OldSpawnHitCount != SpawnHitCount )
		{
			OldSpawnHitCount = SpawnHitCount;
			GetHitInfo();
			PC = Level.GetLocalPlayerController();
			if ( ((Instigator != None) && (Instigator.Controller == PC)) || (VSize(PC.ViewTarget.Location - mHitLocation) < 4000) )
			{
				if( mHitActor!=None )
					Spawn(class'ROBulletHitEffect',,, mHitLocation, Rotator(-mHitNormal));
				CheckForSplash();
				SpawnTracer();
			}
		}
	//}

  	if ( FlashCount>0 )
	{
		if( KFPawn(Instigator)!=None )
		{
			if (FiringMode == 0)
			{
				KFPawn(Instigator).StartFiringX(false,bRapidFire);
			}
			else
            {
                KFPawn(Instigator).StartFiringX(true,bRapidFire);
            }
		}

		if( bDoFiringEffects )
		{
    		PC = Level.GetLocalPlayerController();

    		if ( (Level.TimeSeconds - LastRenderTime > 0.2) && (Instigator.Controller != PC) )
    			return;

    		WeaponLight();

    		DoFlashEmitter();

    		if ( (mShellCaseEmitter == None) && (Level.DetailMode != DM_Low) && !Level.bDropDetail )
    		{
    			mShellCaseEmitter = Spawn(mShellCaseEmitterClass);
    			if ( mShellCaseEmitter != None )
    			    AttachToBone(mShellCaseEmitter, ShellEjectBoneName);
    		}
    		if (mShellCaseEmitter != None)
    			mShellCaseEmitter.mStartParticles++;
		}
	}
	else
	{
		GotoState('');
		if( KFPawn(Instigator)!=None )
			KFPawn(Instigator).StopFiring();
	}
}

defaultproperties
{
    MeshRef="HMG_A.SK_WP_Stinger_3P_Mid"
    mTracerClass=Class'KFMod.SPSniperTracer'

    //mMuzFlashClass=Class'ROEffects.MuzzleFlash3rdMP'
    mMuzFlashClass=Class'ROEffects.MuzzleFlash3rdSPSniper'
    FlashOffset=(Y=40,Z=0)
    FlashRotationOffset=(Pitch=0,Yaw=16384)


    
    mShellCaseEmitterClass=Class'KFMod.KFShellSpewer'
    ShellEjectBoneName="b_gun_ammo"
    MovementAnims(0)="JogF_SCAR"
    MovementAnims(1)="JogB_SCAR"
    MovementAnims(2)="JogL_SCAR"
    MovementAnims(3)="JogR_SCAR"
    TurnLeftAnim="TurnL_SCAR"
    TurnRightAnim="TurnR_SCAR"
    CrouchAnims(0)="CHWalkF_SCAR"
    CrouchAnims(1)="CHWalkB_SCAR"
    CrouchAnims(2)="CHWalkL_SCAR"
    CrouchAnims(3)="CHWalkR_SCAR"
    WalkAnims(0)="WalkF_SCAR"
    WalkAnims(1)="WalkB_SCAR"
    WalkAnims(2)="WalkL_SCAR"
    WalkAnims(3)="WalkR_SCAR"
    CrouchTurnRightAnim="CH_TurnR_SCAR"
    CrouchTurnLeftAnim="CH_TurnL_SCAR"
    IdleCrouchAnim="CHIdle_SCAR"
    IdleWeaponAnim="Idle_SCAR"
    IdleRestAnim="Idle_SCAR"
    IdleChatAnim="Idle_SCAR"
    IdleHeavyAnim="Idle_SCAR"
    IdleRifleAnim="Idle_SCAR"
    FireAnims(0)="Fire_SCAR"
    FireAnims(1)="Fire_SCAR"
    FireAnims(2)="Fire_SCAR"
    FireAnims(3)="Fire_SCAR"
    FireAltAnims(0)="Fire_SCAR"
    FireAltAnims(1)="Fire_SCAR"
    FireAltAnims(2)="Fire_SCAR"
    FireAltAnims(3)="Fire_SCAR"
    FireCrouchAnims(0)="CHFire_SCAR"
    FireCrouchAnims(1)="CHFire_SCAR"
    FireCrouchAnims(2)="CHFire_SCAR"
    FireCrouchAnims(3)="CHFire_SCAR"
    FireCrouchAltAnims(0)="CHFire_SCAR"
    FireCrouchAltAnims(1)="CHFire_SCAR"
    FireCrouchAltAnims(2)="CHFire_SCAR"
    FireCrouchAltAnims(3)="CHFire_SCAR"
    HitAnims(0)="HitF_SCAR"
    HitAnims(1)="HitB_SCAR"
    HitAnims(2)="HitL_SCAR"
    HitAnims(3)="HitR_SCAR"
    PostFireBlendStandAnim="Blend_SCAR"
    PostFireBlendCrouchAnim="CHBlend_SCAR"
    bHeavy=True
    bRapidFire=True
    bAltRapidFire=True
    SplashEffect=Class'ROEffects.BulletSplashEmitter'
    CullDistance=5000.000000
}
