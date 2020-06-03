class ThompsonHPickup extends KFWeaponPickup;

defaultproperties
{
     Weight=6
     cost=500
     AmmoCost=12
     BuyClipSize=50
     PowerValue=30
     SpeedValue=90
     RangeValue=50
     Description="The Thompson is an American submachine gun, invented by John T. Thompson in 1919, that became infamous during the Prohibition era. It was a common sight in the media of the time, being used by both law enforcement officers and criminals."
     ItemName="Heavy Tommy Gun SE"
     ItemShortName="Heavy Tommy"
     AmmoItemName=".45 ACP"
     AmmoMesh=StaticMesh'KillingFloorStatics.L85Ammo'
     CorrespondingPerkIndex=10
     EquipmentCategoryID=2
     InventoryType=Class'ScrnHMG.ThompsonH'
     PickupMessage="You've got the Thompson Submachine Gun"
     PickupSound=Sound'KF_IJC_HalloweenSnd.Handling.Thompson_Handling_Bolt_Back'
     PickupForce="AssaultRiflePickup"
     StaticMesh=StaticMesh'HMG_A.thompson_st'
     CollisionRadius=25.000000
     CollisionHeight=5.000000
}
