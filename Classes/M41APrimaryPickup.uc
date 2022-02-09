class M41APrimaryPickup extends KFWeaponPickup
    abstract;

defaultproperties
{
    Weight=14.000000
    cost=9999
    AmmoCost=66 // bullet cost
    BuyClipSize=33
    PowerValue=70
    SpeedValue=100
    RangeValue=80
    Description="M41A Pulse Rifle. Designed to kill Aliens. Looks especially cool in Sigourney Weaver's hands."
    ItemName="M41A Pulse Rifle SE"
    ItemShortName="Pulse Rifle"
    AmmoItemName="M41A 10 mm caseless ammunition"
    //showmesh=SkeletalMesh'HMG_A.M41APulseRifle3RD'
    AmmoMesh=StaticMesh'KillingFloorStatics.L85Ammo'
    CorrespondingPerkIndex=10
    EquipmentCategoryID=3
    InventoryType=class'M41AAssaultRifle'
    PickupMessage="You got the M41A"
    PickupSound=Sound'HMG_S.M41A.Pickup'
    PickupForce="AssaultRiflePickup"
    StaticMesh=StaticMesh'HMG_A.M41APickup'
    CollisionRadius=25.000000
    CollisionHeight=5.000000
}
