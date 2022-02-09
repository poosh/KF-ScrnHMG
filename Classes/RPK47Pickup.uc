class RPK47Pickup extends KFWeaponPickup;

defaultproperties
{
     cost=2000
     weight=9
     AmmoCost=30
     BuyClipSize=40
     PowerValue=49
     SpeedValue=86
     RangeValue=70
     Description="The RPK (Russian: Ruchnoy Pulemyot Kalashnikova, Kalashnikov hand-held machine gun) is a 7.62x39mm light machine gun of Soviet design, developed by Mikhail Kalashnikov in the late 1950s, parallel with the AKM assault rifle."
     ItemName="RPK-47 SE"
     ItemShortName="RPK-47"
     AmmoItemName="Rounds 7.62x39mm"
     AmmoMesh=StaticMesh'KillingFloorStatics.L85Ammo'
     CorrespondingPerkIndex=10
     EquipmentCategoryID=2
     InventoryType=class'RPK47MachineGun'
     PickupMessage="You picked up the RPK-47"
     PickupSound=Sound'HMG_S.RPK.rpk47_pickup'
     PickupForce="AssaultRiflePickup"
     StaticMesh=StaticMesh'HMG_A.RPK47_st'
     CollisionRadius=25.000000
     CollisionHeight=5.000000
}
