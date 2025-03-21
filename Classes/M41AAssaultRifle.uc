//=============================================================================
// SCAR MK17 Inventory class
//=============================================================================
class M41AAssaultRifle extends KFWeapon
    config(user);

#exec OBJ LOAD FILE=ScrnTex.utx


var string            AmmoText;
var ScriptedTexture   AmmoDigitsScriptedTexture;
var Font              AmmoDigitsFont;
var color             AmmoDigitsColor, LowAmmoDigitsColor, NotReadyDigitsColor;

var const   class<ScrnLocalLaserDot>    LaserDotClass;
var         ScrnLocalLaserDot           LaserDot;             // The first person laser site dot

var()       class<InventoryAttachment>  LaserAttachmentClass;      // First person laser attachment class
var         Vector                      LaserAttachmentOffset;     // relative offset from attachment bone
var         name                        LaserAttachmentBone;     // relative offset from attachment bone
var         Actor                       LaserAttachment; // First person laser attachment
var         byte                        LaserType;

var int OldAmmoAmount;

var float MyYaw;


replication
{
    reliable if(Role < ROLE_Authority)
        ServerSetLaserType;
}


simulated function RenderOverlays( Canvas Canvas )
{
    if (bIsReloading || AmmoAmount(0) <= 0) {
        if (OldAmmoAmount != -4) {
            OldAmmoAmount = -4;
            AmmoText = "--";
            AmmoDigitsColor = NotReadyDigitsColor;
            ++AmmoDigitsScriptedTexture.Revision;
        }
    }
    else if (OldAmmoAmount != MagAmmoRemaining) {
        OldAmmoAmount = MagAmmoRemaining;
        if (MagAmmoRemaining < 10) {
            AmmoText = "0" $ MagAmmoRemaining;
            AmmoDigitsColor = LowAmmoDigitsColor;
        }
        else if (MagAmmoRemaining <= (MagCapacity>>2)) {
            AmmoText = String(MagAmmoRemaining);
            AmmoDigitsColor = LowAmmoDigitsColor;
        }
        else {
            AmmoText = String(MagAmmoRemaining);
            AmmoDigitsColor = default.AmmoDigitsColor;
        }
        ++AmmoDigitsScriptedTexture.Revision;
    }
    AmmoDigitsScriptedTexture.Client = Self;
    LaserRenderOverlays(Canvas);
    default.PlayerViewPivot.Yaw = 0;
    AmmoDigitsScriptedTexture.Client = None;
}

simulated function LaserRenderOverlays( Canvas Canvas )
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

simulated function RenderTexture( ScriptedTexture Tex )
{
    local int w, h;

    Tex.TextSize( AmmoText, AmmoDigitsFont,  w, h );
    Tex.DrawText( ( Tex.USize / 2 ) - ( w / 2.2 ), ( Tex.VSize / 2 ) - ( h / 2.0 ),AmmoText, AmmoDigitsFont, AmmoDigitsColor );
}

simulated function ZoomIn(bool bAnimateTransition)
{
    default.PlayerViewPivot.Yaw = 0;
    PlayerViewPivot.Yaw = 0;

    super.ZoomIn(bAnimateTransition);
}

simulated function ZoomOut(bool bAnimateTransition)
{
    // rotate weapon a little bit to face more to the PoV
    default.PlayerViewPivot.Yaw = MyYaw;
    PlayerViewPivot.Yaw = MyYaw;

    super.ZoomOut(bAnimateTransition);
}

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
        LaserType = default.LaserType;
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

exec function SwitchModes()
{
    DoToggle();
}


defaultproperties
{
    LaserType=1  // Red
    LaserAttachmentClass=Class'ScrnLaserAttachmentFirstPerson'
    LaserAttachmentBone="LightBone"
    LaserDotClass=Class'ScrnLocalLaserDot'

    HudImageRef="HMG_T.M41A.HUD.M41A_unselected"
    SelectedHudImageRef="HMG_T.M41A.HUD.M41A_selected"
    SelectSoundRef="HMG_S.M41A.Select"
    MeshRef="HMG_A.M41APulseRifle"
    SkinRefs(0)="HMG_T.M41A.M41A_cmb_final"

    AmmoDigitsScriptedTexture=ScriptedTexture'HMG_T.M41A.AmmoText'
    AmmoDigitsFont=Font'BDFonts.DigitalMed'
    AmmoDigitsColor=(R=76,G=148,B=177,A=255)
    LowAmmoDigitsColor=(R=218,G=18,B=18,A=255)
    NotReadyDigitsColor=(R=218,G=18,B=18,A=255)

    bHasSecondaryAmmo=True
    bReduceMagAmmoOnSecondaryFire=False
    bIsTier3Weapon=True

    MagCapacity=33
    ReloadRate=2.000000
    ReloadAnim="Reload"
    ReloadAnimRate=1.500000
    WeaponReloadAnim="Reload_SCAR"
    Weight=14.000000
    bHasAimingMode=True
    IdleAimAnim="Idle_Iron"
    StandardDisplayFOV=55.000000
    bModeZeroCanDryFire=True
    TraderInfoTexture=Texture'HMG_T.M41A.HUD.Trader_M41A'
    PlayerIronSightFOV=70.000000
    ZoomedDisplayFOV=45.000000
    FireModeClass(0)=class'M41AFire'
    FireModeClass(1)=class'M41AALTFire'
    PutDownAnim="PutDown"
    SelectForce="SwitchToAssaultRifle"
    AIRating=0.550000
    CurrentRating=0.550000
    //bShowChargingBar=True
    //AmmoClass(0)=class'M41AAmmo'
    //AmmoClass(1)=class'M41AProjectileAmmo'
    Description="M41A Pulse Rifle. Designed to kill Aliens. Looks especially cool in Sigourney Weaver's hands."
    EffectOffset=(X=100.000000,Y=25.000000,Z=-10.000000)
    DisplayFOV=55.000000
    Priority=160
    CustomCrosshair=11
    CustomCrossHairTextureName="Crosshairs.HUD.Crosshair_Cross5"
    InventoryGroup=4
    GroupOffset=7
    PickupClass=class'M41APickup'

    //PlayerViewOffset=(X=20.000000,Y=19.000000,Z=3.000000)
    PlayerViewOffset=(X=25.000000,Y=24.000000,Z=8.000000)
    PlayerViewPivot=(Yaw=-648)
    MyYaw = -648

    BobDamping=6.000000
    //AttachmentClass=class'M41AAttachment'
    AttachmentClass=class'M41AAttachment'
    IconCoords=(X1=245,Y1=39,X2=329,Y2=79)
    ItemName="M41A Pulse Rifle SE"

    TransientSoundVolume=5.250000
}
