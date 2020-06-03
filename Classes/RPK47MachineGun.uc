class RPK47MachineGun extends KFWeapon
    config(user);


// Use alt fire to switch fire modes
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

//TODO: LONG ranged?
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
    HudImageRef="HMG_T.RPK.RPK47_Unselected"
    SelectedHudImageRef="HMG_T.RPK.RPK47_selected"
    SelectSoundRef="HMG_S.RPK.rpk47_select"
    MeshRef="HMG_A.RPK47_mesh"
    SkinRefs(0)="HMG_T.RPK.RPK_0"
    SkinRefs(1)="KF_Weapons3_Trip_T.hands.Priest_Hands_1st_P"
    SkinRefs(2)="HMG_T.RPK.RPK_1"
    SkinRefs(3)="HMG_T.RPK.RPK_2"
    SkinRefs(4)="HMG_T.RPK.RPK_3"
    SkinRefs(5)="HMG_T.RPK.RPK_4"
    SkinRefs(6)="HMG_T.RPK.RPK_5"
    SkinRefs(7)="HMG_T.RPK.RPK_6"
    SkinRefs(8)="HMG_T.RPK.RPK_7"
    SkinRefs(9)="KF_Weapons2_Trip_T.Special.Aimpoint_sight_shdr"

    weight=9
    MagCapacity=40
    ReloadRate=3.00
    ReloadAnim="Reload"
    ReloadAnimRate=1.000000
    WeaponReloadAnim="Reload_AK47"
    bHasAimingMode=True
    IdleAimAnim="Iron_Idle"
    StandardDisplayFOV=65.000000
    bModeZeroCanDryFire=True
    TraderInfoTexture=Texture'HMG_T.RPK.RPK47_Trader'
    bIsTier2Weapon=true
    PlayerIronSightFOV=65.000000
    ZoomedDisplayFOV=32.000000
    FireModeClass(0)=Class'ScrnHMG.RPK47Fire'
    FireModeClass(1)=Class'KFMod.NoFire'
    PutDownAnim="PutDown"
    SelectForce="SwitchToAssaultRifle"
    AIRating=0.550000
    CurrentRating=0.550000
    bShowChargingBar=True
    Description="The RPK (Russian: Ruchnoy Pulemyot Kalashnikova, Kalashnikov hand-held machine gun) is a 7.62x39mm light machine gun of Soviet design, developed by Mikhail Kalashnikov in the late 1950s, parallel with the AKM assault rifle."
    EffectOffset=(X=100.000000,Y=25.000000,Z=-10.000000)
    DisplayFOV=65.000000
    Priority=125
    CustomCrosshair=11
    CustomCrossHairTextureName="Crosshairs.HUD.Crosshair_Cross5"
    InventoryGroup=3
    GroupOffset=7
    PickupClass=Class'ScrnHMG.RPK47Pickup'
    PlayerViewOffset=(X=8.000000,Y=8.000000,Z=-3.000000)
    BobDamping=4.000000
    AttachmentClass=Class'ScrnHMG.RPK47Attachment'
    IconCoords=(X1=245,Y1=39,X2=329,Y2=79)
    TransientSoundVolume=1.250000
    ItemName="RPK-47 SE"
}
