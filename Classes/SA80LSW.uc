class SA80LSW extends KFWeapon;

//=============================================================================
// Execs
//=============================================================================
#exec OBJ LOAD FILE=ScopeShaders.utx

var color ChargeColor;

var float Range;
var float LastRangingTime;

var() Material ZoomMat;
var() Sound ZoomSound;
var bool bArrowRemoved;

var()        int            lenseMaterialID;        // used since material id's seem to change alot

var()        float        scopePortalFOVHigh;        // The FOV to zoom the scope portal by.
var()        float        scopePortalFOV;            // The FOV to zoom the scope portal by.
var()       vector      XoffsetScoped;
var()       vector      XoffsetHighDetail;

// Not sure if these pitch vars are still needed now that we use Scripted Textures. We'll keep for now in case they are. - Ramm 08/14/04
var()        int            scopePitch;                // Tweaks the pitch of the scope firing angle
var()        int            scopeYaw;                // Tweaks the yaw of the scope firing angle
var()        int            scopePitchHigh;            // Tweaks the pitch of the scope firing angle high detail scope
var()        int            scopeYawHigh;            // Tweaks the yaw of the scope firing angle high detail scope

// 3d Scope vars
var   ScriptedTexture   ScopeScriptedTexture;   // Scripted texture for 3d scopes
var      Shader            ScopeScriptedShader;       // The shader that combines the scripted texture with the sight overlay
var   Material          ScriptedTextureFallback;// The texture to render if the users system doesn't support shaders

var     Combiner            ScriptedScopeCombiner;

var     texture             TexturedScopeTexture;

var        bool                bInitializedScope;        // Set to true when the scope has been initialized
// var(Zooming)    float       ZoomedDisplayFOVHigh;       // What is the DisplayFOV when zoomed in
// var     float               ForceZoomOutTime;


var        string ZoomMatRef;
var        string ScriptedTextureFallbackRef;

var     texture         CrosshairTex;
var        string          CrosshairTexRef;

//=============================================================================
// Functions
//=============================================================================

static function PreloadAssets(Inventory Inv, optional bool bSkipRefCount)
{
    local SA80LSW W;

    super.PreloadAssets(Inv, bSkipRefCount);

    default.ZoomMat = FinalBlend(DynamicLoadObject(default.ZoomMatRef, class'FinalBlend', true));
    default.ScriptedTextureFallback = texture(DynamicLoadObject(default.ScriptedTextureFallbackRef, class'texture', true));
    default.CrosshairTex = texture(DynamicLoadObject(default.CrosshairTexRef, class'texture', true));

    W = SA80LSW(Inv);
    if ( W != none ) {
        W.ZoomMat = default.ZoomMat;
        W.ScriptedTextureFallback = default.ScriptedTextureFallback;
        W.CrosshairTex = default.CrosshairTex;
    }
}

static function bool UnloadAssets()
{
    if ( super.UnloadAssets() ) {
        default.ZoomMat = none;
        default.ScriptedTextureFallback = none;
        default.CrosshairTex = none;

        return true;
    }

    return false;
}

//======================================================================
simulated function AltFire(float F)
{
    if(ReadyToFire(0))
    {
        DoToggle();
    }
}

exec function SwitchModes()
{
    DoToggle();
}


function bool RecommendRangedAttack()
{
    return true;
}

function bool RecommendLongRangedAttack()
{
    return true;
}

function float SuggestAttackStyle()
{
    return -1.0;
}

// Helper function for the scope system. The scope system checks here to see when it should draw the portal.
// if you want to limit any times the portal should/shouldn't be drawn, add them here.
// Ramm 10/27/03
simulated function bool ShouldDrawPortal()
{
//    local     name    thisAnim;
//    local    float     animframe;
//    local    float     animrate;
//
//    GetAnimParams(0, thisAnim,animframe,animrate);

//    if(bUsingSights && (IsInState('Idle') || IsInState('PostFiring')) && thisAnim != 'scope_shoot_last')
    if( bAimingRifle )
        return true;
    else
        return false;
}

simulated function PostBeginPlay()
{
    super.PostBeginPlay();

    // Get new scope detail value from KFWeapon
    KFScopeDetail = class'KFMod.KFWeapon'.default.KFScopeDetail;

    UpdateScopeMode();
}

// Handles initializing and swithing between different scope modes
simulated function UpdateScopeMode()
{
    if (Level.NetMode != NM_DedicatedServer && Instigator != none && Instigator.IsLocallyControlled() &&
        Instigator.IsHumanControlled() )
    {
        if( KFScopeDetail == KF_ModelScope )
        {
            scopePortalFOV = default.scopePortalFOV;
            ZoomedDisplayFOV = default.ZoomedDisplayFOV;
            //bPlayerFOVZooms = false;
            if (bUsingSights)
            {
                PlayerViewOffset = XoffsetScoped;
            }

            if( ScopeScriptedTexture == none )
            {
                ScopeScriptedTexture = ScriptedTexture(Level.ObjectPool.AllocateObject(class'ScriptedTexture'));
            }

            ScopeScriptedTexture.FallBackMaterial = ScriptedTextureFallback;
            ScopeScriptedTexture.SetSize(512,512);
            ScopeScriptedTexture.Client = Self;


            if( ScriptedScopeCombiner == none )
            {
                // Construct the Combiner
                ScriptedScopeCombiner = Combiner(Level.ObjectPool.AllocateObject(class'Combiner'));
                ScriptedScopeCombiner.Material1 = CrosshairTex;
                ScriptedScopeCombiner.FallbackMaterial = Shader'ScopeShaders.Zoomblur.LensShader';
                ScriptedScopeCombiner.CombineOperation = CO_Multiply;
                ScriptedScopeCombiner.AlphaOperation = AO_Use_Mask;
                ScriptedScopeCombiner.Material2 = ScopeScriptedTexture;
            }

            if( ScopeScriptedShader == none )
            {
                // Construct the scope shader
                ScopeScriptedShader = Shader(Level.ObjectPool.AllocateObject(class'Shader'));
                ScopeScriptedShader.Diffuse = ScriptedScopeCombiner;
                ScopeScriptedShader.SelfIllumination = ScriptedScopeCombiner;
                ScopeScriptedShader.FallbackMaterial = Shader'ScopeShaders.Zoomblur.LensShader';
            }

            bInitializedScope = true;
        }
        else if( KFScopeDetail == KF_ModelScopeHigh )
        {
            scopePortalFOV = scopePortalFOVHigh;
            ZoomedDisplayFOV = default.ZoomedDisplayFOVHigh;
            //bPlayerFOVZooms = false;
            if (bUsingSights)
            {
                PlayerViewOffset = XoffsetHighDetail;
            }

            if( ScopeScriptedTexture == none )
            {
                ScopeScriptedTexture = ScriptedTexture(Level.ObjectPool.AllocateObject(class'ScriptedTexture'));
            }
            ScopeScriptedTexture.FallBackMaterial = ScriptedTextureFallback;
            ScopeScriptedTexture.SetSize(512,512);
            ScopeScriptedTexture.Client = Self;

            if( ScriptedScopeCombiner == none )
            {
                // Construct the Combiner
                ScriptedScopeCombiner = Combiner(Level.ObjectPool.AllocateObject(class'Combiner'));
                ScriptedScopeCombiner.Material1 = CrosshairTex;
                ScriptedScopeCombiner.FallbackMaterial = Shader'ScopeShaders.Zoomblur.LensShader';
                ScriptedScopeCombiner.CombineOperation = CO_Multiply;
                ScriptedScopeCombiner.AlphaOperation = AO_Use_Mask;
                ScriptedScopeCombiner.Material2 = ScopeScriptedTexture;
            }

            if( ScopeScriptedShader == none )
            {
                // Construct the scope shader
                ScopeScriptedShader = Shader(Level.ObjectPool.AllocateObject(class'Shader'));
                ScopeScriptedShader.Diffuse = ScriptedScopeCombiner;
                ScopeScriptedShader.SelfIllumination = ScriptedScopeCombiner;
                ScopeScriptedShader.FallbackMaterial = Shader'ScopeShaders.Zoomblur.LensShader';
            }

            bInitializedScope = true;
        }
        else if (KFScopeDetail == KF_TextureScope)
        {
            ZoomedDisplayFOV = default.ZoomedDisplayFOV;
            PlayerViewOffset.X = default.PlayerViewOffset.X;
            //bPlayerFOVZooms = true;

            bInitializedScope = true;
        }
    }
}

simulated event RenderTexture(ScriptedTexture Tex)
{
    local rotator RollMod;

    RollMod = Instigator.GetViewRotation();
    //RollMod.Roll -= 16384;

//    Rpawn = ROPawn(Instigator);
//    // Subtract roll from view while leaning - Ramm
//    if (Rpawn != none && rpawn.LeanAmount != 0)
//    {
//        RollMod.Roll += rpawn.LeanAmount;
//    }

    if(Owner != none && Instigator != none && Tex != none && Tex.Client != none)
        Tex.DrawPortal(0,0,Tex.USize,Tex.VSize,Owner,(Instigator.Location + Instigator.EyePosition()), RollMod,  scopePortalFOV );
}

simulated function SetZoomBlendColor(Canvas c)
{
    local Byte    val;
    local Color   clr;
    local Color   fog;

    clr.R = 255;
    clr.G = 255;
    clr.B = 255;
    clr.A = 255;

    if( Instigator.Region.Zone.bDistanceFog )
    {
        fog = Instigator.Region.Zone.DistanceFogColor;
        val = 0;
        val = Max( val, fog.R);
        val = Max( val, fog.G);
        val = Max( val, fog.B);
        if( val > 128 )
        {
            val -= 128;
            clr.R -= val;
            clr.G -= val;
            clr.B -= val;
        }
    }
    c.DrawColor = clr;
}


/**
 * Handles all the functionality for zooming in including
 * setting the parameters for the weapon, pawn, and playercontroller
 *
 * @param bAnimateTransition whether or not to animate this zoom transition
 */
simulated function ZoomIn(bool bAnimateTransition)
{
    super(BaseKFWeapon).ZoomIn(bAnimateTransition);

    bAimingRifle = True;

    if( KFHumanPawn(Instigator)!=None )
        KFHumanPawn(Instigator).SetAiming(True);

    if( Level.NetMode != NM_DedicatedServer && KFPlayerController(Instigator.Controller) != none )
    {
        if( AimInSound != none )
        {
            PlayOwnedSound(AimInSound, SLOT_Interact,,,,, false);
        }
    }
}

/**
 * Handles all the functionality for zooming out including
 * setting the parameters for the weapon, pawn, and playercontroller
 *
 * @param bAnimateTransition whether or not to animate this zoom transition
 */
simulated function ZoomOut(bool bAnimateTransition)
{
    super.ZoomOut(bAnimateTransition);

    bAimingRifle = False;

    if( KFHumanPawn(Instigator)!=None )
        KFHumanPawn(Instigator).SetAiming(False);

    if( Level.NetMode != NM_DedicatedServer && KFPlayerController(Instigator.Controller) != none )
    {
        if( AimOutSound != none )
        {
            PlayOwnedSound(AimOutSound, SLOT_Interact,,,,, false);
        }
        KFPlayerController(Instigator.Controller).TransitionFOV(KFPlayerController(Instigator.Controller).DefaultFOV,0.0);
    }
}

simulated function WeaponTick(float dt)
{
    super.WeaponTick(dt);

    if( bAimingRifle && ForceZoomOutTime > 0 && Level.TimeSeconds - ForceZoomOutTime > 0 )
    {
        ForceZoomOutTime = 0;

        ZoomOut(false);

        if( Role < ROLE_Authority)
            ServerZoomOut(false);
    }
}


/**
 * Called by the native code when the interpolation of the first person weapon to the zoomed position finishes
 */
simulated event OnZoomInFinished()
{
    local name anim;
    local float frame, rate;

    GetAnimParams(0, anim, frame, rate);

    if (ClientState == WS_ReadyToFire)
    {
        // Play the iron idle anim when we're finished zooming in
        if (anim == IdleAnim)
        {
           PlayIdle();
        }
    }

    if( Level.NetMode != NM_DedicatedServer && KFPlayerController(Instigator.Controller) != none &&
        KFScopeDetail == KF_TextureScope )
    {
        KFPlayerController(Instigator.Controller).TransitionFOV(PlayerIronSightFOV,0.0);
    }
}

simulated function bool CanZoomNow()
{
    Return (!FireMode[0].bIsFiring && Instigator!=None && Instigator.Physics!=PHYS_Falling);
}

simulated event RenderOverlays(Canvas Canvas)
{
    local int m;
    local PlayerController PC;

    if (Instigator == None)
        return;

    // Lets avoid having to do multiple casts every tick - Ramm
    PC = PlayerController(Instigator.Controller);

    if(PC == None)
        return;

    if(!bInitializedScope && PC != none )
    {
          UpdateScopeMode();
    }

    // draw muzzleflashes/smoke for all fire modes so idle state won't
    // cause emitters to just disappear
    Canvas.DrawActor(None, false, true); // amb: Clear the z-buffer here

    for (m = 0; m < NUM_FIRE_MODES; m++)
    {
        if (FireMode[m] != None)
        {
            FireMode[m].DrawMuzzleFlash(Canvas);
        }
    }


    SetLocation( Instigator.Location + Instigator.CalcDrawOffset(self) );
    SetRotation( Instigator.GetViewRotation() + ZoomRotInterp);

    PreDrawFPWeapon();    // Laurent -- Hook to override things before render (like rotation if using a staticmesh)

     if(bAimingRifle && PC != none && (KFScopeDetail == KF_ModelScope || KFScopeDetail == KF_ModelScopeHigh))
     {
         if (ShouldDrawPortal())
         {
            if ( ScopeScriptedTexture != none )
            {
                Skins[LenseMaterialID] = ScopeScriptedShader;
                ScopeScriptedTexture.Client = Self;   // Need this because this can get corrupted - Ramm
                ScopeScriptedTexture.Revision = (ScopeScriptedTexture.Revision +1);
            }
         }

        bDrawingFirstPerson = true;
         Canvas.DrawBoundActor(self, false, false,DisplayFOV,PC.Rotation,rot(0,0,0),Instigator.CalcZoomedDrawOffset(self));
          bDrawingFirstPerson = false;
    }
    // Added "bInIronViewCheck here. Hopefully it prevents us getting the scope overlay when not zoomed.
    // Its a bit of a band-aid solution, but it will work til we get to the root of the problem - Ramm 08/12/04
    else if( KFScopeDetail == KF_TextureScope && PC.DesiredFOV == PlayerIronSightFOV && bAimingRifle)
    {
        Skins[LenseMaterialID] = ScriptedTextureFallback;

        SetZoomBlendColor(Canvas);

        //Black-out either side of the main zoom circle.
        Canvas.Style = ERenderStyle.STY_Normal;
        Canvas.SetPos(0, 0);
        Canvas.DrawTile(ZoomMat, (Canvas.SizeX - Canvas.SizeY) / 2, Canvas.SizeY, 0.0, 0.0, 8, 8);
        Canvas.SetPos(Canvas.SizeX, 0);
        Canvas.DrawTile(ZoomMat, -(Canvas.SizeX - Canvas.SizeY) / 2, Canvas.SizeY, 0.0, 0.0, 8, 8);

        //The view through the scope itself.
        Canvas.Style = 255;
        Canvas.SetPos((Canvas.SizeX - Canvas.SizeY) / 2,0);
        Canvas.DrawTile(ZoomMat, Canvas.SizeY, Canvas.SizeY, 0.0, 0.0, 512, 512);

        //Draw some useful text.
        Canvas.Font = Canvas.MedFont;
        Canvas.SetDrawColor(200,150,0);

        Canvas.SetPos(Canvas.SizeX * 0.16, Canvas.SizeY * 0.43);
        Canvas.DrawText(" "); //Canvas.DrawText("Zoom: 2.50");

        Canvas.SetPos(Canvas.SizeX * 0.16, Canvas.SizeY * 0.47);
    }
     else
     {
        Skins[LenseMaterialID] = ScriptedTextureFallback;
        bDrawingFirstPerson = true;
        Canvas.DrawActor(self, false, false, DisplayFOV);
        bDrawingFirstPerson = false;
     }
}

//=============================================================================
// Scopes
//=============================================================================

//------------------------------------------------------------------------------
// SetScopeDetail(RO) - Allow the players to change scope detail while ingame.
//    Changes are saved to the ini file.
//------------------------------------------------------------------------------
//simulated exec function SetScopeDetail()
//{
//    if( !bHasScope )
//        return;
//
//    if (KFScopeDetail == KF_ModelScope)
//        KFScopeDetail = KF_TextureScope;
//    else if ( KFScopeDetail == KF_TextureScope)
//        KFScopeDetail = KF_ModelScopeHigh;
//    else if ( KFScopeDetail == KF_ModelScopeHigh)
//        KFScopeDetail = KF_ModelScope;
//
//    AdjustIngameScope();
//    class'KFMod.KFWeapon'.default.KFScopeDetail = KFScopeDetail;
//    class'KFMod.KFWeapon'.static.StaticSaveConfig();        // saves the new scope detail value to the ini
//}

//------------------------------------------------------------------------------
// AdjustIngameScope(RO) - Takes the changes to the ScopeDetail variable and
//    sets the scope to the new detail mode. Called when the player switches the
//    scope setting ingame, or when the scope setting is changed from the menu
//------------------------------------------------------------------------------
simulated function AdjustIngameScope()
{
    local PlayerController PC;

    // Lets avoid having to do multiple casts every tick - Ramm
    PC = PlayerController(Instigator.Controller);

    if( !bHasScope )
        return;

    switch (KFScopeDetail)
    {
        case KF_ModelScope:
            if( bAimingRifle )
                DisplayFOV = default.ZoomedDisplayFOV;
            if ( PC.DesiredFOV == PlayerIronSightFOV && bAimingRifle )
            {
                if( Level.NetMode != NM_DedicatedServer && KFPlayerController(Instigator.Controller) != none )
                {
                    KFPlayerController(Instigator.Controller).TransitionFOV(KFPlayerController(Instigator.Controller).DefaultFOV,0.0);
}
            }
            break;

        case KF_TextureScope:
            if( bAimingRifle )
                DisplayFOV = default.ZoomedDisplayFOV;
            if ( bAimingRifle && PC.DesiredFOV != PlayerIronSightFOV )
            {
                if( Level.NetMode != NM_DedicatedServer && KFPlayerController(Instigator.Controller) != none )
                {
                    KFPlayerController(Instigator.Controller).TransitionFOV(PlayerIronSightFOV,0.0);
                }
            }
            break;

        case KF_ModelScopeHigh:
            if( bAimingRifle )
            {
                if( ZoomedDisplayFOVHigh > 0 )
                    DisplayFOV = default.ZoomedDisplayFOVHigh;
                else
                    DisplayFOV = default.ZoomedDisplayFOV;
            }
            if ( bAimingRifle && PC.DesiredFOV == PlayerIronSightFOV )
            {
                if( Level.NetMode != NM_DedicatedServer && KFPlayerController(Instigator.Controller) != none )
                {
                    KFPlayerController(Instigator.Controller).TransitionFOV(KFPlayerController(Instigator.Controller).DefaultFOV,0.0);
                }
            }
            break;
    }

    // Make any chagned to the scope setup
    UpdateScopeMode();
}

simulated event Destroyed()
{
    if (ScopeScriptedTexture != None)
    {
        ScopeScriptedTexture.Client = None;
        Level.ObjectPool.FreeObject(ScopeScriptedTexture);
        ScopeScriptedTexture=None;
    }

    if (ScriptedScopeCombiner != None)
    {
        ScriptedScopeCombiner.Material2 = none;
        Level.ObjectPool.FreeObject(ScriptedScopeCombiner);
        ScriptedScopeCombiner = none;
    }

    if (ScopeScriptedShader != None)
    {
        ScopeScriptedShader.Diffuse = none;
        ScopeScriptedShader.SelfIllumination = none;
        Level.ObjectPool.FreeObject(ScopeScriptedShader);
        ScopeScriptedShader = none;
    }

    Super.Destroyed();
}

simulated function PreTravelCleanUp()
{
    if (ScopeScriptedTexture != None)
    {
        ScopeScriptedTexture.Client = None;
        Level.ObjectPool.FreeObject(ScopeScriptedTexture);
        ScopeScriptedTexture=None;
    }

    if (ScriptedScopeCombiner != None)
    {
        ScriptedScopeCombiner.Material2 = none;
        Level.ObjectPool.FreeObject(ScriptedScopeCombiner);
        ScriptedScopeCombiner = none;
    }

    if (ScopeScriptedShader != None)
    {
        ScopeScriptedShader.Diffuse = none;
        ScopeScriptedShader.SelfIllumination = none;
        Level.ObjectPool.FreeObject(ScopeScriptedShader);
        ScopeScriptedShader = none;
    }
}

defaultproperties
{
    HudImageRef="HMG_T.SA80.SA80LSW_Unselected"
    SelectedHudImageRef="HMG_T.SA80.SA80LSW_selected"
    SelectSoundRef="HMG_S.SA80.SA80LSW_select"
    MeshRef="HMG_A.SA80LSW_mesh"
    SkinRefs(0)="HMG_T.SA80.SA80LSW_1"
    SkinRefs(1)="KF_Weapons3_Trip_T.hands.Priest_Hands_1st_P"
    SkinRefs(2)="HMG_T.SA80.SA80LSW_2"
    SkinRefs(3)="HMG_T.SA80.SA80LSW_3"
    SkinRefs(4)="HMG_T.SA80.SA80LSW_4"
    SkinRefs(5)="HMG_T.SA80.SA80LSW_5"
    SkinRefs(6)="HMG_T.SA80.SA80LSW_6"
    SkinRefs(7)="KF_Weapons_Trip_T.Rifles.CBLens_cmb"
    SkinRefs(8)="HMG_T.SA80.alpha_lens_64x64"

    ZoomMatRef="HMG_T.SA80.SA80crosshairs_FB"
    ScriptedTextureFallbackRef="HMG_T.SA80.alpha_lens_64x64"
    CrosshairTexRef="HMG_T.SA80.SA80crosshairs"

    PickupClass=class'SA80LSWPickup'
    AttachmentClass=class'SA80LSWAttachment'
    FireModeClass(0)=class'SA80LSWFire'
    FireModeClass(1)=Class'KFMod.NoFire'

    TraderInfoTexture=Texture'HMG_T.SA80.SA80LSW_Trader'
    lenseMaterialID=8
    scopePortalFOVHigh=13.000000
    scopePortalFOV=13.000000
    ZoomedDisplayFOVHigh=50.000000
    bHasScope=True
    MagCapacity=45
    ReloadRate=3.500000
    ReloadAnim="Reload"
    ReloadAnimRate=1.000000
    WeaponReloadAnim="Reload_BullPup"
    Weight=7
    bIsTier2Weapon=true
    bHasAimingMode=True
    IdleAimAnim="Iron_Idle"
    StandardDisplayFOV=65.000000
    bModeZeroCanDryFire=True
    PlayerIronSightFOV=32.000000
    ZoomedDisplayFOV=50.000000
    PutDownAnim="PutDown"
    SelectForce="SwitchToAssaultRifle"
    AIRating=0.650000
    CurrentRating=0.650000
    Description="The SA80 (Small Arms for the 1980s) is a British family of 5.56mm small arms. It is a selective fire, gas-operated assault rifle. Elements of its design, in particular the bullpup configuration, come from the earlier EM-2 rifle."
    DisplayFOV=65.000000
    Priority=100
    CustomCrosshair=11
    CustomCrossHairTextureName="Crosshairs.HUD.Crosshair_Cross5"
    InventoryGroup=3
    GroupOffset=3
    PlayerViewOffset=(X=20.000000,Y=10.000000,Z=-2.000000)
    BobDamping=5.000000
    IconCoords=(X1=253,Y1=146,X2=333,Y2=181)
    ItemName="SA80 LSW SE"
}
