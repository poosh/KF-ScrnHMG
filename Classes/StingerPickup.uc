class StingerPickup extends KFWeaponPickup;

defaultproperties
{
    Weight=14
    cost=7500
    PowerValue=50
    SpeedValue=95
    RangeValue=30
    Description="Stinger Minigun first was designed by Liandri corp. as a mining tool, but later converted into military service. Fires shards of unprocessed Tarydium crystal."
    AmmoItemName="7.62x51mm"
    AmmoMesh=StaticMesh'KillingFloorStatics.L85Ammo'
    CorrespondingPerkIndex=10
    EquipmentCategoryID=3
    InventoryType=class'Stinger'
    PickupMessage="You've picked up a Stinger Minigun"
    PickupSound=Sound'HMG_S.Stinger.StingerTakeOut'
    PickupForce="AssaultRiflePickup"
    StaticMesh=StaticMesh'HMG_A.UT3StingerPickup'
    CollisionRadius=25.000000
    CollisionHeight=5.000000

    AmmoCost=75 // Since now there are less bullets in clip and they do less damage
    BuyClipSize=123
    ItemName="Stinger Minigun SE"
    ItemShortName="Stinger SE "
}
