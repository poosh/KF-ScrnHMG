class M249SAW extends KFWeapon
    config(user);

var bool bAllBulletsVisible;


simulated function AltFire(float F)
{
    DoToggle();
}

exec function SwitchModes()
{
    DoToggle();
}

simulated function DoToggle()
{
    super.DoToggle();
    ScrnFire(FireMode[0]).FireModeChanged();
}

function ServerChangeFireMode(bool bNewWaitForRelease)
{
    super.ServerChangeFireMode(bNewWaitForRelease);
    ScrnFire(FireMode[0]).FireModeChanged();
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

simulated function Notify_ShowBullets()
{
    if ( bAllBulletsVisible )
        return;

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

    bAllBulletsVisible = true;
}

simulated function Notify_HideBullets()
{
    if ( MagAmmoRemaining >= 10 ) {
        Notify_ShowBullets();
    }
    else {
        bAllBulletsVisible = false;
        SetBoneScale(0, 0.0, 'Bullet01b');
        SetBoneScale(1, float(MagAmmoRemaining > 8), 'Bullet02b');
        SetBoneScale(2, float(MagAmmoRemaining > 7), 'Bullet03b');
        SetBoneScale(3, float(MagAmmoRemaining > 6), 'Bullet04b');
        SetBoneScale(4, float(MagAmmoRemaining > 5), 'Bullet05b');
        SetBoneScale(5, float(MagAmmoRemaining > 4), 'Bullet06b');
        SetBoneScale(6, float(MagAmmoRemaining > 3), 'Bullet07b');
        SetBoneScale(7, float(MagAmmoRemaining > 2), 'Bullet08b');
        SetBoneScale(8, float(MagAmmoRemaining > 1), 'Bullet09b');
        SetBoneScale(9, float(MagAmmoRemaining > 0), 'Bullet10b');
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

     MagCapacity=50
     ReloadRate=5.000000
     ReloadAnim="Reload"
     ReloadAnimRate=1.000000
     WeaponReloadAnim="Reload_AK47"
     Weight=12
     bHasAimingMode=True
     IdleAimAnim="Iron_Idle"
     StandardDisplayFOV=65.000000
     bModeZeroCanDryFire=True
     SleeveNum=0
     TraderInfoTexture=Texture'HMG_T.M249.m249_Trader'
     bIsTier3Weapon=True
     PlayerIronSightFOV=65.000000
     ZoomedDisplayFOV=32.000000
     FireModeClass(0)=class'M249Fire'
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
     PickupClass=class'M249Pickup'
     PlayerViewOffset=(X=5.000000,Y=5.500000,Z=-3.000000)
     BobDamping=4.000000
     AttachmentClass=class'M249Attachment'
     IconCoords=(X1=245,Y1=39,X2=329,Y2=79)
     ItemName="M249 SAW SE"
     DrawScale=0.600000
     TransientSoundVolume=1.250000
}
