class ThompsonH extends KFWeapon
    config(user);


function bool RecommendRangedAttack()
{
    return true;
}

function bool RecommendLongRangedAttack()
{
    return false;
}

function float SuggestAttackStyle()
{
    return -1.0;
}


defaultproperties
{
     MagCapacity=50
     ReloadRate=3.000000
     ReloadAnim="Reload"
     ReloadAnimRate=1.000000
     WeaponReloadAnim="Reload_AK47"
     Weight=6
     bHasAimingMode=True
     IdleAimAnim="Iron_Idle"
     StandardDisplayFOV=65.000000
     bModeZeroCanDryFire=True
     SleeveNum=0
     TraderInfoTexture=Texture'HMG_T.Thompson.Thompson_Trader'
     MeshRef="HMG_A.thompson_mesh"
     SkinRefs(0)="KF_Weapons_Trip_T.hands.hands_1stP_military_cmb"
     SkinRefs(1)="HMG_T.Thompson.Main"
     SkinRefs(2)="HMG_T.Thompson.stuff"
     SelectSoundRef="KF_IJC_HalloweenSnd.Thompson_Handling_Bolt_Back"
     HudImageRef="HMG_T.Thompson.Thompson_unselected"
     SelectedHudImageRef="HMG_T.Thompson.Thompson_selected"
     PlayerIronSightFOV=65.000000
     ZoomedDisplayFOV=32.000000
     FireModeClass(0)=class'ThompsonHFire'
     FireModeClass(1)=Class'KFMod.NoFire'
     PutDownAnim="PutDown"
     SelectForce="SwitchToAssaultRifle"
     AIRating=0.550000
     CurrentRating=0.550000
     bShowChargingBar=True
     Description="The Thompson is an American submachine gun, invented by John T. Thompson in 1919, that became infamous during the Prohibition era. It was a common sight in the media of the time, being used by both law enforcement officers and criminals."
     EffectOffset=(X=100.000000,Y=25.000000,Z=-10.000000)
     DisplayFOV=65.000000
     Priority=95
     CustomCrosshair=11
     CustomCrossHairTextureName="Crosshairs.HUD.Crosshair_Cross5"
     InventoryGroup=3
     GroupOffset=7
     PickupClass=class'ThompsonHPickup'
     PlayerViewOffset=(X=4.000000,Y=5.000000,Z=-3.000000)
     BobDamping=4.000000
     AttachmentClass=class'ThompsonHAttachment'
     IconCoords=(X1=245,Y1=39,X2=329,Y2=79)
     ItemName="Heavy Tommy Gun SE"
     TransientSoundVolume=1.250000
}
