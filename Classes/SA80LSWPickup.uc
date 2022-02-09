class SA80LSWPickup extends KFWeaponPickup;

defaultproperties
{
    Weight=7
    cost=1000
    AmmoCost=12 // up from 10

    BuyClipSize=45
    PowerValue=41
    SpeedValue=60
    RangeValue=60
    Description="The SA80 (Small Arms for the 1980s) is a British family of 5.56mm small arms. It is a selective fire, gas-operated assault rifle. Elements of its design, in particular the bullpup configuration, come from the earlier EM-2 rifle."
    ItemName="SA80 LSW SE"
    ItemShortName="SA80 LSW"
    AmmoItemName="Rounds 5.56x45"
    //showmesh=SkeletalMesh'HMG_A.SA80LSW_3rd'
    CorrespondingPerkIndex=10
    EquipmentCategoryID=2
    InventoryType=class'SA80LSW'
    PickupMessage="You picked up the SA80 LSW"
    PickupSound=Sound'HMG_S.SA80.SA80LSW_pickup'
    PickupForce="AssaultRiflePickup"
    StaticMesh=StaticMesh'HMG_A.SA80LSW_st'
    DrawScale=1.500000
    CollisionRadius=30.000000
    CollisionHeight=5.000000
}
