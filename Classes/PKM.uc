class PKM extends KFWeapon
    config(user);


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


defaultproperties
{
    HudImageRef="HMG_T.PKM.PKM_Unselected"
    SelectedHudImageRef="HMG_T.PKM.PKM_selected"
    SelectSoundRef="HMG_S.PKM.pkm_draw"
    MeshRef="HMG_A.pkmmesh"
    SkinRefs(0)="HMG_T.PKM.wpn_pkm"
    SkinRefs(1)="HMG_T.PKM.wpn_pkm_lenta"
    SkinRefs(2)="KF_Weapons_Trip_T.hands.hands_1stP_military_cmb"

    weight=12
    MagCapacity=65
    ReloadRate=6.000000
    ReloadAnim="Reload"
    ReloadAnimRate=1.000000
    FlashBoneName="tip_1"
    WeaponReloadAnim="Reload_M14"
    bHasAimingMode=True
    IdleAimAnim="Iron_Idle"
    QuickPutDownTime=0.300000
    QuickBringUpTime=0.300000
    StandardDisplayFOV=65.000000
    bModeZeroCanDryFire=True
    SleeveNum=2
    TraderInfoTexture=Texture'HMG_T.PKM.PKM_Trader'
    bIsTier2Weapon=True
    PlayerIronSightFOV=65.000000
    ZoomedDisplayFOV=32.000000
    FireModeClass(0)=class'PKMFire'
    FireModeClass(1)=Class'KFMod.NoFire'
    PutDownAnim="PutDown"
    SelectForce="SwitchToAssaultRifle"
    AIRating=0.550000
    CurrentRating=0.550000
    bShowChargingBar=True
    Description="The PKM (Kalashnikov's Machine-gun Modernized) adopted to service in 1969. It is a modernized, product-improved version of the PK (Pulemyot Kalashnikova)."
    EffectOffset=(X=100.000000,Y=25.000000,Z=-10.000000)
    DisplayFOV=65.000000
    Priority=190
    CustomCrosshair=11
    CustomCrossHairTextureName="Crosshairs.HUD.Crosshair_Cross5"
    InventoryGroup=3
    GroupOffset=7
    PickupClass=class'PKMPickup'
    PlayerViewOffset=(X=-10.000000,Y=18.000000,Z=-11.000000)
    BobDamping=5.000000
    AttachmentClass=class'PKMAttachment'
    IconCoords=(X1=245,Y1=39,X2=329,Y2=79)
    ItemName="PKM SE"
    TransientSoundVolume=1.250000
}
