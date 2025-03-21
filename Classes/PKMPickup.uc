class PKMPickup extends KFWeaponPickup;

defaultproperties
{
     cost=4000
     weight=12
     AmmoCost=50
     BuyClipSize=65
     PowerValue=55
     SpeedValue=86
     RangeValue=70
     Description="The PKM (Kalashnikov's Machine-gun Modernized) adopted to service in 1969. It is a modernized, product-improved version of the PK (Pulemyot Kalashnikova)"
     ItemName="PKM SE"
     ItemShortName="PKM"
     AmmoItemName="PKM 7.62x54mm"
     //showmesh=SkeletalMesh'HMG_A.pkm3rd'
     AmmoMesh=StaticMesh'KillingFloorStatics.L85Ammo'
     CorrespondingPerkIndex=10
     EquipmentCategoryID=2
     InventoryType=class'PKM'
     PickupMessage="You picked up the PKM"
     PickupSound=Sound'HMG_S.PKM.pkm_holster'
     PickupForce="AssaultRiflePickup"
     StaticMesh=StaticMesh'HMG_A.PkmSM'
     CollisionRadius=25.000000
     CollisionHeight=5.000000
}
