class XMV850Pickup extends KFWeaponPickup;

#EXEC OBJ LOAD FILE=HMG_T.utx
#EXEC OBJ LOAD FILE=HMG_S.uax
#EXEC OBJ LOAD FILE=HMG_A.ukx


defaultproperties
{
     Weight=10
     cost=3000
     AmmoCost=35
     BuyClipSize=120
     PowerValue=40
     SpeedValue=100
     RangeValue=50
     Description="Minigan with reduced fire rate down to 950RPM. But still badass and has laser sight."
     ItemName="XMV850 Minigun SE"
     ItemShortName="XMV850 Minigun"
     AmmoItemName="7.62x51mm Ammo"
     AmmoMesh=StaticMesh'KillingFloorStatics.L85Ammo'
     CorrespondingPerkIndex=10
     EquipmentCategoryID=3
     InventoryType=Class'ScrnHMG.XMV850M'
     PickupMessage="You got the XMV850 Minigun."
     PickupSound=Sound'HMG_S.XMV.XMV-Pullout'
     PickupForce="AssaultRiflePickup"
     StaticMesh=StaticMesh'HMG_A.XMV850Pickup'
     CollisionRadius=25.000000
     CollisionHeight=5.000000
}
