class M249SAW extends KFWeapon
	config(user);


function bool RecommendRangedAttack()
{
	return true;
}

//TODO: LONG ranged?
function bool RecommendLongRangedAttack()
{
	return false;
}

function float SuggestAttackStyle()
{
	return -1.0;
}

exec function SwitchModes()
{
	DoToggle();
}

function float GetAIRating()
{
	local Bot B;

	B = Bot(Instigator.Controller);
	if ( (B == None) || (B.Enemy == None) )
		return AIRating;

	return AIRating;
}

function byte BestMode()
{
	return 0;
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


simulated function Notify_ShowBullets ()
{
			SetBoneScale (0, 1.0, 'Bullet01b');
			SetBoneScale (1, 1.0, 'Bullet02b');
			SetBoneScale (2, 1.0, 'Bullet03b');
			SetBoneScale (3, 1.0, 'Bullet04b');
			SetBoneScale (4, 1.0, 'Bullet05b');
			SetBoneScale (5, 1.0, 'Bullet06b');
			SetBoneScale (6, 1.0, 'Bullet07b');
			SetBoneScale (7, 1.0, 'Bullet08b');
			SetBoneScale (8, 1.0, 'Bullet09b');
			SetBoneScale (9, 1.0, 'Bullet10b');
}

simulated function Notify_HideBullets ()
{
	if (MagAmmoRemaining == 0)
		{
			SetBoneScale (0, 0.0, 'Bullet01b');
			SetBoneScale (1, 0.0, 'Bullet02b');
			SetBoneScale (2, 0.0, 'Bullet03b');
			SetBoneScale (3, 0.0, 'Bullet04b');
			SetBoneScale (4, 0.0, 'Bullet05b');
			SetBoneScale (5, 0.0, 'Bullet06b');
			SetBoneScale (6, 0.0, 'Bullet07b');
			SetBoneScale (7, 0.0, 'Bullet08b');
			SetBoneScale (8, 0.0, 'Bullet09b');
			SetBoneScale (9, 0.0, 'Bullet10b');
		}
	else if (MagAmmoRemaining == 1)
		{
			SetBoneScale (0, 0.0, 'Bullet01b');
			SetBoneScale (1, 0.0, 'Bullet02b');
			SetBoneScale (2, 0.0, 'Bullet03b');
			SetBoneScale (3, 0.0, 'Bullet04b');
			SetBoneScale (4, 0.0, 'Bullet05b');
			SetBoneScale (5, 0.0, 'Bullet06b');
			SetBoneScale (6, 0.0, 'Bullet07b');
			SetBoneScale (7, 0.0, 'Bullet08b');
			SetBoneScale (8, 0.0, 'Bullet09b');
			SetBoneScale (9, 1.0, 'Bullet10b');
		}
	else if (MagAmmoRemaining == 2)
		{
			SetBoneScale (0, 0.0, 'Bullet01b');
			SetBoneScale (1, 0.0, 'Bullet02b');
			SetBoneScale (2, 0.0, 'Bullet03b');
			SetBoneScale (3, 0.0, 'Bullet04b');
			SetBoneScale (4, 0.0, 'Bullet05b');
			SetBoneScale (5, 0.0, 'Bullet06b');
			SetBoneScale (6, 0.0, 'Bullet07b');
			SetBoneScale (7, 0.0, 'Bullet08b');
			SetBoneScale (8, 1.0, 'Bullet09b');
			SetBoneScale (9, 1.0, 'Bullet10b');
		}
	else if (MagAmmoRemaining == 3)
		{
			SetBoneScale (0, 0.0, 'Bullet01b');
			SetBoneScale (1, 0.0, 'Bullet02b');
			SetBoneScale (2, 0.0, 'Bullet03b');
			SetBoneScale (3, 0.0, 'Bullet04b');
			SetBoneScale (4, 0.0, 'Bullet05b');
			SetBoneScale (5, 0.0, 'Bullet06b');
			SetBoneScale (6, 0.0, 'Bullet07b');
			SetBoneScale (7, 1.0, 'Bullet08b');
			SetBoneScale (8, 1.0, 'Bullet09b');
			SetBoneScale (9, 1.0, 'Bullet10b');
		}
	else if (MagAmmoRemaining == 4)
		{
			SetBoneScale (0, 0.0, 'Bullet01b');
			SetBoneScale (1, 0.0, 'Bullet02b');
			SetBoneScale (2, 0.0, 'Bullet03b');
			SetBoneScale (3, 0.0, 'Bullet04b');
			SetBoneScale (4, 0.0, 'Bullet05b');
			SetBoneScale (5, 0.0, 'Bullet06b');
			SetBoneScale (6, 1.0, 'Bullet07b');
			SetBoneScale (7, 1.0, 'Bullet08b');
			SetBoneScale (8, 1.0, 'Bullet09b');
			SetBoneScale (9, 1.0, 'Bullet10b');
		}
	else if (MagAmmoRemaining == 5)
		{
			SetBoneScale (0, 0.0, 'Bullet01b');
			SetBoneScale (1, 0.0, 'Bullet02b');
			SetBoneScale (2, 0.0, 'Bullet03b');
			SetBoneScale (3, 0.0, 'Bullet04b');
			SetBoneScale (4, 0.0, 'Bullet05b');
			SetBoneScale (5, 1.0, 'Bullet06b');
			SetBoneScale (6, 1.0, 'Bullet07b');
			SetBoneScale (7, 1.0, 'Bullet08b');
			SetBoneScale (8, 1.0, 'Bullet09b');
			SetBoneScale (9, 1.0, 'Bullet10b');
		}
	else if (MagAmmoRemaining == 6)
		{
			SetBoneScale (0, 0.0, 'Bullet01b');
			SetBoneScale (1, 0.0, 'Bullet02b');
			SetBoneScale (2, 0.0, 'Bullet03b');
			SetBoneScale (3, 0.0, 'Bullet04b');
			SetBoneScale (4, 1.0, 'Bullet05b');
			SetBoneScale (5, 1.0, 'Bullet06b');
			SetBoneScale (6, 1.0, 'Bullet07b');
			SetBoneScale (7, 1.0, 'Bullet08b');
			SetBoneScale (8, 1.0, 'Bullet09b');
			SetBoneScale (9, 1.0, 'Bullet10b');
		}
	else if (MagAmmoRemaining == 7)
		{
			SetBoneScale (0, 0.0, 'Bullet01b');
			SetBoneScale (1, 0.0, 'Bullet02b');
			SetBoneScale (2, 0.0, 'Bullet03b');
			SetBoneScale (3, 1.0, 'Bullet04b');
			SetBoneScale (4, 1.0, 'Bullet05b');
			SetBoneScale (5, 1.0, 'Bullet06b');
			SetBoneScale (6, 1.0, 'Bullet07b');
			SetBoneScale (7, 1.0, 'Bullet08b');
			SetBoneScale (8, 1.0, 'Bullet09b');
			SetBoneScale (9, 1.0, 'Bullet10b');
		}
	else if (MagAmmoRemaining == 8)
		{
			SetBoneScale (0, 0.0, 'Bullet01b');
			SetBoneScale (1, 0.0, 'Bullet02b');
			SetBoneScale (2, 1.0, 'Bullet03b');
			SetBoneScale (3, 1.0, 'Bullet04b');
			SetBoneScale (4, 1.0, 'Bullet05b');
			SetBoneScale (5, 1.0, 'Bullet06b');
			SetBoneScale (6, 1.0, 'Bullet07b');
			SetBoneScale (7, 1.0, 'Bullet08b');
			SetBoneScale (8, 1.0, 'Bullet09b');
			SetBoneScale (9, 1.0, 'Bullet10b');
		}
	else if (MagAmmoRemaining == 9)
		{
			SetBoneScale (0, 0.0, 'Bullet01b');
			SetBoneScale (1, 1.0, 'Bullet02b');
			SetBoneScale (2, 1.0, 'Bullet03b');
			SetBoneScale (3, 1.0, 'Bullet04b');
			SetBoneScale (4, 1.0, 'Bullet05b');
			SetBoneScale (5, 1.0, 'Bullet06b');
			SetBoneScale (6, 1.0, 'Bullet07b');
			SetBoneScale (7, 1.0, 'Bullet08b');
			SetBoneScale (8, 1.0, 'Bullet09b');
			SetBoneScale (9, 1.0, 'Bullet10b');
		}
				
	else
		{
			SetBoneScale (0, 1.0, 'Bullet01b');
			SetBoneScale (1, 1.0, 'Bullet02b');
			SetBoneScale (2, 1.0, 'Bullet03b');
			SetBoneScale (3, 1.0, 'Bullet04b');
			SetBoneScale (4, 1.0, 'Bullet05b');
			SetBoneScale (5, 1.0, 'Bullet06b');
			SetBoneScale (6, 1.0, 'Bullet07b');
			SetBoneScale (7, 1.0, 'Bullet08b');
			SetBoneScale (8, 1.0, 'Bullet09b');
			SetBoneScale (9, 1.0, 'Bullet10b');
		}
}

defaultproperties
{
     HudImageRef="HMG_T.M249.m249_Unselected"
     SelectedHudImageRef="HMG_T.M249.m249_selected"
     SelectSoundRef="HMG_S.M249.m249_select"
     MeshRef="HMG_A.m249mesh"
     SkinRefs(0)="KF_Weapons_Trip_T.hands.hands_1stP_military_cmb"
     SkinRefs(1)="HMG_T.M249.v_m249"
     SkinRefs(2)="HMG_T.M249.v_m249_addons"
     SkinRefs(3)="HMG_T.M249.v_m249_box"
     SkinRefs(4)="HMG_T.M249.v_m249_bullets"
     SkinRefs(5)="HMG_T.M249.v_m249_front"
     SkinRefs(6)="HMG_T.M249.v_m249_heatshield"
     SkinRefs(7)="HMG_T.M249.v_m249_lid"
     SkinRefs(8)="HMG_T.M249.v_m249_receiver"
     SkinRefs(9)="HMG_T.M249.v_m249_sights"
     SkinRefs(10)="HMG_T.M249.v_m249_stock"

     MagCapacity=60
     ReloadRate=5.000000
     ReloadAnim="Reload"
     ReloadAnimRate=1.000000
     WeaponReloadAnim="Reload_AK47"
     Weight=12.000000 //11
     bHasAimingMode=True
     IdleAimAnim="Iron_Idle"
     StandardDisplayFOV=65.000000
     bModeZeroCanDryFire=True
     SleeveNum=0
     TraderInfoTexture=Texture'HMG_T.M249.m249_Trader'
     bIsTier3Weapon=True
     PlayerIronSightFOV=65.000000
     ZoomedDisplayFOV=32.000000
     FireModeClass(0)=Class'ScrnHMG.M249Fire'
     FireModeClass(1)=Class'KFMod.NoFire'
     PutDownAnim="PutDown"
     SelectAnimRate=1.000000
     SelectForce="SwitchToAssaultRifle"
     AIRating=0.550000
     CurrentRating=0.550000
     bShowChargingBar=True
     Description="The M249 SAW/LMG is the US produced version of the the Belgian-made FN Minimi. The M249 uses the 5.56x45mm NATO round, which lowers the weight of the gun when loaded yet grants the user with highly accurate yet reasonably powerful fire."
     EffectOffset=(X=100.000000,Y=25.000000,Z=-10.000000)
     DisplayFOV=65.000000
     Priority=150
     CustomCrosshair=11
     CustomCrossHairTextureName="Crosshairs.HUD.Crosshair_Cross5"
     InventoryGroup=4
     GroupOffset=7
     PickupClass=Class'ScrnHMG.M249Pickup'
     PlayerViewOffset=(X=5.000000,Y=5.500000,Z=-3.000000)
     BobDamping=4.000000
     AttachmentClass=Class'ScrnHMG.M249Attachment'
     IconCoords=(X1=245,Y1=39,X2=329,Y2=79)
     ItemName="M249 SAW SE"
     DrawScale=0.600000
     TransientSoundVolume=1.250000
}
