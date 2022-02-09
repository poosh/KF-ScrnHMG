class M249Pickup extends KFWeaponPickup;

defaultproperties
{
     Weight=13
     cost=5000
     AmmoCost=65
     BuyClipSize=50
     PowerValue=62
     SpeedValue=92
     RangeValue=60
     Description="The M249 SAW/LMG is the US produced version of the the Belgian-made FN Minimi. The M249 uses the 5.56x45mm NATO round, which lowers the weight of the gun when loaded yet grants the user with highly accurate yet reasonably powerful fire."
     ItemName="M249 SAW SE"
     ItemShortName="M249 SAW SE"
     AmmoItemName="5.56x45mm NATO"
     //showmesh=SkeletalMesh'HMG_A.m249_3rd'
     AmmoMesh=StaticMesh'KillingFloorStatics.L85Ammo'
     CorrespondingPerkIndex=10
     EquipmentCategoryID=2
     InventoryType=class'M249SAW'
     PickupMessage="You picked up the M249 SAW SE"
     PickupSound=Sound'HMG_S.M249.m249_pickup'
     PickupForce="AssaultRiflePickup"
     StaticMesh=StaticMesh'HMG_A.M249_ST'
     CollisionRadius=25.000000
     CollisionHeight=5.000000
}
