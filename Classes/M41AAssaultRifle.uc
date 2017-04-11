//=============================================================================
// SCAR MK17 Inventory class
//=============================================================================
class M41AAssaultRifle extends KFWeapon
	config(user);

var string MyMessage;

var ScriptedTexture   AmmoDigitsScriptedTexture;
var Font              AmmoDigitsFont;
var color             AmmoDigitsColor, LowAmmoDigitsColor;

var int OldAmmoAmount;

var float MyYaw;


//=============================================================================
// Functions
//=============================================================================
simulated function RenderOverlays( Canvas Canvas )
{
 	if( AmmoAmount(0) <= 0 )
	{
		if( OldAmmoAmount!=-5 )
		{
			OldAmmoAmount = -5;
            AmmoDigitsColor.R = 218;
            AmmoDigitsColor.G = 18;
            AmmoDigitsColor.B = 18;
			MyMessage = "--";
			++AmmoDigitsScriptedTexture.Revision;
		}
	}
	else if( bIsReloading )
	{
		if( OldAmmoAmount!=-4 )
		{
			OldAmmoAmount = -4;
            AmmoDigitsColor.R = 218;
            AmmoDigitsColor.G = 218;
            AmmoDigitsColor.B = 18;
			MyMessage = "RL";
			++AmmoDigitsScriptedTexture.Revision;
		}
	}
	else if( OldAmmoAmount!=(MagAmmoRemaining+1) )
	{
		OldAmmoAmount = MagAmmoRemaining+1;

		if ( MagAmmoRemaining <= (MagCapacity>>2) )
            AmmoDigitsColor = LowAmmoDigitsColor;
            AmmoDigitsColor = default.AmmoDigitsColor;

		MyMessage = String(MagAmmoRemaining);
		++AmmoDigitsScriptedTexture.Revision;
	}

	AmmoDigitsScriptedTexture.Client = Self;
    
	Super.RenderOverlays(Canvas);
    default.PlayerViewPivot.Yaw = 0;
	AmmoDigitsScriptedTexture.Client = None;
}

simulated function RenderTexture( ScriptedTexture Tex )
{
	local int w, h;

	Tex.TextSize( MyMessage, AmmoDigitsFont,  w, h );	
	Tex.DrawText( ( Tex.USize / 2 ) - ( w / 2.2 ), ( Tex.VSize / 2 ) - ( h / 2.0 ),MyMessage, AmmoDigitsFont, AmmoDigitsColor );
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



defaultproperties
{
     HudImageRef="HMG_T.M41A.HUD.M41A_unselected"
     SelectedHudImageRef="HMG_T.M41A.HUD.M41A_selected"
     SelectSoundRef="HMG_S.M41A.Select"
     MeshRef="HMG_A.M41APulseRifle"
     SkinRefs(0)="HMG_T.M41A.M41A_cmb_final"

     AmmoDigitsScriptedTexture=ScriptedTexture'HMG_T.M41A.AmmoText'
     AmmoDigitsFont=Font'BDFonts.DigitalMed'
     AmmoDigitsColor=(B=177,G=148,R=76,A=255)
     LowAmmoDigitsColor=(B=18,G=18,R=218,A=255)
     
     
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
     FireModeClass(0)=Class'ScrnHMG.M41AFire'
     FireModeClass(1)=Class'ScrnHMG.M41AALTFire'
     PutDownAnim="PutDown"
     SelectForce="SwitchToAssaultRifle"
     AIRating=0.550000
     CurrentRating=0.550000
     //bShowChargingBar=True
     //AmmoClass(0)=Class'ScrnHMG.M41AAmmo'
     //AmmoClass(1)=Class'ScrnHMG.M41AProjectileAmmo'
     Description="M41A Pulse Rifle. Designed to kill Aliens. Looks especially cool in Sigourney Weaver's hands."
     EffectOffset=(X=100.000000,Y=25.000000,Z=-10.000000)
     DisplayFOV=55.000000
     Priority=160
     CustomCrosshair=11
     CustomCrossHairTextureName="Crosshairs.HUD.Crosshair_Cross5"
     InventoryGroup=4
     GroupOffset=7
     PickupClass=Class'ScrnHMG.M41APickup'
     
     //PlayerViewOffset=(X=20.000000,Y=19.000000,Z=3.000000)
     PlayerViewOffset=(X=25.000000,Y=24.000000,Z=8.000000)
     PlayerViewPivot=(Yaw=-648)
     MyYaw = -648
     
     BobDamping=6.000000
     //AttachmentClass=Class'ScrnHMG.M41AAttachment'
     AttachmentClass=Class'ScrnHMG.M41AAttachmentBeta'
     IconCoords=(X1=245,Y1=39,X2=329,Y2=79)
     ItemName="M41A Pulse Rifle SE"

     TransientSoundVolume=5.250000
}
