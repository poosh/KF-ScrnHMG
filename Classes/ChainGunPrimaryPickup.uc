class ChainGunPrimaryPickup extends KFWeaponPickup
    abstract;

defaultproperties
{
     Weight=17.000000
     cost=10999
     AmmoCost=80
     BuyClipSize=150
     PowerValue=80
     SpeedValue=100
     RangeValue=60
     Description="Chaingun ripped from dead Patriarch's hand. Or maybe ripped WITH. Or even WITH ALIVE. It works and nothing else matters."
     ItemName="Pat's Chaingun SE"
     ItemShortName="Chaingun SE"
     AmmoItemName="Chaingun Bullets"
     AmmoMesh=StaticMesh'KillingFloorStatics.FT_AmmoMesh'
     CorrespondingPerkIndex=10
     EquipmentCategoryID=3
     MaxDesireability=0.790000
     InventoryType=Class'ScrnHMG.ChainGun'
     PickupMessage="You got the Patriarch's Chain Gun."
     PickupSound=Sound'KF_HuskGunSnd.foley.Husk_Pickup'
     PickupForce="AssaultRiflePickup"
     StaticMesh=StaticMesh'kf_gore_trip_sm.limbs.Patriarch_Gun_Arm_Resource'
     CollisionRadius=25.000000
     CollisionHeight=10.000000
}
