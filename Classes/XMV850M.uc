class XMV850M extends KFWeapon
	config(user);

var float DesiredSpeed;
var float BarrelSpeed;
var int BarrelTurn;

var() Sound BarrelSpinSound,BarrelStopSound,BarrelStartSound;
var() String BarrelSpinSoundRef,BarrelStopSoundRef,BarrelStartSoundRef;




var const   class<ScrnLocalLaserDot>    LaserDotClass;
var         ScrnLocalLaserDot           LaserDot;             // The first person laser site dot

var()       class<InventoryAttachment>  LaserAttachmentClass;      // First person laser attachment class
var         Vector                      LaserAttachmentOffset;     // relative offset from attachment bone
var         name                        LaserAttachmentBone;     // relative offset from attachment bone
var         Actor                       LaserAttachment; // First person laser attachment
var         byte                        LaserType;


replication
{
    reliable if(Role < ROLE_Authority)
        ServerSetLaserType;
}

static function PreloadAssets(Inventory Inv, optional bool bSkipRefCount)
{
    local XMV850M W;

	super.PreloadAssets(Inv, bSkipRefCount);

	default.BarrelSpinSound = sound(DynamicLoadObject(default.BarrelSpinSoundRef, class'sound', true));
	default.BarrelStopSound = sound(DynamicLoadObject(default.BarrelStopSoundRef, class'sound', true));
	default.BarrelStartSound = sound(DynamicLoadObject(default.BarrelStartSoundRef, class'sound', true));

    W = XMV850M(Inv);
	if ( W != none ) {
		W.BarrelSpinSound = default.BarrelSpinSound;
		W.BarrelStopSound = default.BarrelStopSound;
		W.BarrelStartSound = default.BarrelStartSound;
	}
}

static function bool UnloadAssets()
{
	if ( super.UnloadAssets() )
	{
		default.BarrelSpinSound = none;
		default.BarrelStopSound = none;
		default.BarrelStartSound = none;
	}

	return true;
}

// XMV uses custom hands
simulated function HandleSleeveSwapping() { }

simulated function Destroyed()
{
    if (LaserDot != None)
        LaserDot.Destroy();
    if (LaserAttachment != None)
        LaserAttachment.Destroy();

    super.Destroyed();
}


simulated event WeaponTick(float dt)
{
	local Rotator bt;

	super.WeaponTick(dt);

	bt.Roll = BarrelTurn;
	SetBoneRotation('Barrels', bt);
	DesiredSpeed = 0.50;
}

simulated event Tick(float dt)
{
	local float OldBarrelTurn;

    super.Tick(dt);

	if(FireMode[0].IsFiring()) {
		BarrelSpeed = BarrelSpeed + FClamp(DesiredSpeed - BarrelSpeed, -0.20 * dt, 0.40 * dt);
		BarrelTurn += int(BarrelSpeed * float(655360) * dt);
	}
	else {
		if( BarrelSpeed > 0 ) {
			BarrelSpeed = FMax(BarrelSpeed - 0.10 * dt, 0.01);
			OldBarrelTurn = float(BarrelTurn);
			BarrelTurn += int(BarrelSpeed * float(655360) * dt);
			if(BarrelSpeed <= 0.03 && (int(OldBarrelTurn / 10922.67) < int(float(BarrelTurn) / 10922.67)))
			{
				BarrelTurn = int(float(int(float(BarrelTurn) / 10922.67)) * 10922.67);
				BarrelSpeed = 0.00;
				PlaySound(BarrelStopSound, SLOT_None, 0.50,, 32.00, 1.00, true);
				AmbientSound = none;
			}
		}
	}
	if( BarrelSpeed > 0 ) {
		AmbientSound = BarrelSpinSound;
		SoundPitch = byte(float(32) + float(96) * BarrelSpeed);
	}

	if( XMV850Attachment(ThirdPersonActor) != none)
		XMV850Attachment(ThirdPersonActor).BarrelSpeed = BarrelSpeed;
}




simulated function bool StartFire(int Mode)
{
	if( Mode == 1 )
		return super.StartFire(Mode);

	if( !super.StartFire(Mode) )
	   return false;

	if( AmmoAmount(0) <= 0 )
	{
    	return false;
    	}

	AnimStopLooping();

	if( !FireMode[Mode].IsInState('FireLoop') && (AmmoAmount(0) > 0) )
	{
		FireMode[Mode].StartFiring();
		return true;
	}
	else
	{
		return false;
	}
	return true;
}

simulated function AnimEnd(int channel)
{
    local name anim;
    local float frame, rate;

	if(!FireMode[0].IsInState('FireLoop'))
	{
        	GetAnimParams(0, anim, frame, rate);

        	if (ClientState == WS_ReadyToFire)
        	{
             		if ((FireMode[0] == None || !FireMode[0].bIsFiring) && (FireMode[1] == None || !FireMode[1].bIsFiring))
            		{
                		PlayIdle();
            		}
        	}
	}
}


simulated function AltFire(float F)
{
    ToggleLaser();
}


//bring Laser to current state, which is indicating by LaserType
simulated function ApplyLaserState()
{
	if( Role < ROLE_Authority  )
		ServerSetLaserType(LaserType);

    if ( ThirdPersonActor != none )
        ScrnLaserWeaponAttachment(ThirdPersonActor).SetLaserType(LaserType);

    if ( !Instigator.IsLocallyControlled() )
        return;

	if(LaserType > 0 ) {
        if ( LaserDot == none )
            LaserDot = Spawn(LaserDotClass, self);
        LaserDot.SetLaserType(LaserType);
		//spawn 1-st person laser attachment for weapon owner
		if ( LaserAttachment == none ) {
			LaserAttachment = Spawn(LaserAttachmentClass,,,,);
            AttachToBone(LaserAttachment,LaserAttachmentBone);
            LaserAttachment.SetRelativeLocation(LaserAttachmentOffset);
        }
		ConstantColor'ScrnTex.Laser.LaserColor'.Color =
			LaserDot.GetLaserColor(); // LaserAttachment's color
        LaserAttachment.bHidden = false;
    }
	else {
		if ( LaserAttachment != none )
			LaserAttachment.bHidden = true;
        if ( LaserDot != none )
            LaserDot.Destroy(); //bHidden = true;
	}
}
// Toggle laser on or off
simulated function ToggleLaser()
{
    if( !Instigator.IsLocallyControlled() )
        return;

    if ( LaserType == 0 )
        LaserType = 3; // Blue
    else
        LaserType = 0;

    ApplyLaserState();
}

simulated function BringUp(optional Weapon PrevWeapon)
{
    ApplyLaserState();
    Super.BringUp(PrevWeapon);
}

simulated function bool PutDown()
{
    TurnOffLaser();
    return super.PutDown();
}

simulated function DetachFromPawn(Pawn P)
{
    TurnOffLaser();
    Super.DetachFromPawn(P);
}

simulated function TurnOffLaser()
{
	if( !Instigator.IsLocallyControlled() )
		return;

    if( Role < ROLE_Authority  )
        ServerSetLaserType(0);

    //don't change Laser type here, because we need to restore it state
    //when next time weapon will be bringed up
    if ( LaserAttachment != none )
        LaserAttachment.bHidden = true;
    if (LaserDot != None)
        LaserDot.Destroy();
}

// Set the new fire mode on the server
function ServerSetLaserType(byte NewLaserType)
{
    LaserType = NewLaserType;
    ScrnLaserWeaponAttachment(ThirdPersonActor).SetLaserType(LaserType);
}

simulated function RenderOverlays( Canvas Canvas )
{
    local int i;
    local Vector StartTrace, EndTrace;
    local Vector HitLocation, HitNormal;
    local Actor Other;
    local vector X,Y,Z;
    local coords C;
	local KFFire KFM;
    local array<Actor> HitActors;

    if (Instigator == None)
        return;

    if ( Instigator.Controller != None )
        Hand = Instigator.Controller.Handedness;

    if ((Hand < -1.0) || (Hand > 1.0))
        return;

    // draw muzzleflashes/smoke for all fire modes so idle state won't
    // cause emitters to just disappear
    for ( i = 0; i < NUM_FIRE_MODES; ++i ) {
        if (FireMode[i] != None)
            FireMode[i].DrawMuzzleFlash(Canvas);
    }

    SetLocation( Instigator.Location + Instigator.CalcDrawOffset(self) );
    SetRotation( Instigator.GetViewRotation() + ZoomRotInterp);

	KFM = KFFire(FireMode[0]);

    // Handle drawing the laser dot
    if ( LaserDot != None )
    {
        //move LaserDot during fire animation too  -- PooSH
        if( bIsReloading )
		{
            C = GetBoneCoords(LaserAttachmentBone);
            X = C.XAxis;
            Y = C.YAxis;
            Z = C.ZAxis;
        }
        else
            GetViewAxes(X, Y, Z);

        StartTrace = Instigator.Location + Instigator.EyePosition();
        EndTrace = StartTrace + 65535 * X;

        while (true) {
            Other = Trace(HitLocation, HitNormal, EndTrace, StartTrace, true);
            if ( ROBulletWhipAttachment(Other) != none ) {
                HitActors[HitActors.Length] = Other;
                Other.SetCollision(false);
                StartTrace = HitLocation + X;
            }
            else {
                if (Other != None && Other != Instigator && Other.Base != Instigator )
                    EndBeamEffect = HitLocation;
                else
                    EndBeamEffect = EndTrace;
                break;
            }
        }
        // restore collision
        for ( i=0; i<HitActors.Length; ++i )
            HitActors[i].SetCollision(true);

        LaserDot.SetLocation(EndBeamEffect - X*LaserDot.ProjectorPullback);

        if(  Pawn(Other) != none ) {
            LaserDot.SetRotation(Rotator(X));
            LaserDot.SetDrawScale(LaserDot.default.DrawScale * 0.5);
        }
        else if( HitNormal == vect(0,0,0) ) {
            LaserDot.SetRotation(Rotator(-X));
            LaserDot.SetDrawScale(LaserDot.default.DrawScale);
        }
        else {
            LaserDot.SetRotation(Rotator(-HitNormal));
            LaserDot.SetDrawScale(LaserDot.default.DrawScale);
        }
    }

    //PreDrawFPWeapon();    // Laurent -- Hook to override things before render (like rotation if using a staticmesh)

    bDrawingFirstPerson = true;
    Canvas.DrawActor(self, false, false, DisplayFOV);
    bDrawingFirstPerson = false;
}

exec function SwitchModes()
{
	DoToggle();
}


defaultproperties
{
     MeshRef="HMG_A.XMV850Mesh"
     SkinRefs(0)="HMG_T.XMV.XMV850_Main"
     SkinRefs(1)="HMG_T.XMV.Hands_Shdr"
     SkinRefs(2)="HMG_T.XMV.XMV850_Barrels_Shdr"
     SelectSoundRef="HMG_S.XMV.XMV-Pullout"
     HudImageRef="HMG_T.XMV.XMV850_Unselected"
     SelectedHudImageRef="HMG_T.XMV.XMV850_Selected"

     BarrelSpinSoundRef="HMG_S.XMV.XMV-BarrelSpinLoop"
     BarrelStopSoundRef="HMG_S.XMV.XMV-BarrelSpinEnd"
     BarrelStartSoundRef="HMG_S.XMV.XMV-BarrelSpinStart"

     LaserAttachmentClass=Class'ScrnBalanceSrv.ScrnLaserAttachmentFirstPerson'
     LaserAttachmentOffset=(X=120,Z=-10)
     LaserAttachmentBone="Muzzle"
     LaserDotClass=Class'ScrnBalanceSrv.ScrnLocalLaserDot'

     MagCapacity=100
     ReloadRate=4.400000
     ReloadAnim="Reload"
     ReloadAnimRate=1.000000
     WeaponReloadAnim="Reload"
     Weight=10
     bIsTier2Weapon=true	 
     StandardDisplayFOV=55.000000
     bModeZeroCanDryFire=True
     TraderInfoTexture=Texture'HMG_T.XMV.Trader_XMV850'
     PlayerIronSightFOV=65.000000
     ZoomedDisplayFOV=20.000000
     FireModeClass(0)=Class'ScrnHMG.XMV850Fire'
     FireModeClass(1)=Class'KFMod.NoFire'
     PutDownAnim="Putaway"
     SelectForce="SwitchToAssaultRifle"
     AIRating=0.550000
     CurrentRating=0.550000
     bShowChargingBar=True
     Description="Minigun with reduced fire rate down to 950RPM. But still badass and has laser sights."
     EffectOffset=(X=100.000000,Y=25.000000,Z=-10.000000)
     DisplayFOV=55.000000
     Priority=135
     CustomCrosshair=11
     CustomCrossHairTextureName="Crosshairs.HUD.Crosshair_Cross5"
     InventoryGroup=3
     GroupOffset=7
     PickupClass=Class'ScrnHMG.XMV850Pickup'
     PlayerViewOffset=(X=30.000000,Y=20.000000,Z=-10.000000)
     BobDamping=6.000000
     AttachmentClass=Class'ScrnHMG.XMV850Attachment'
     IconCoords=(X1=245,Y1=39,X2=329,Y2=79)
     ItemName="XMV850 Minigun SE"
     TransientSoundVolume=1.250000
}
