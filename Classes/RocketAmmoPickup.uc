//=============================================================================
// HuskGunAmmoPickup
//=============================================================================
// Ammo pickup class for the Husk Gun primary fire
//=============================================================================
// Killing Floor Source
// Copyright (C) 2011 Tripwire Interactive LLC
// - John "Ramm-Jaeger" Gibson
//=============================================================================
class RocketAmmoPickup extends KFAmmoPickup;

defaultproperties
{
     AmmoAmount=1
     InventoryType=class'RocketAmmo'
     PickupMessage="Rockets"
     StaticMesh=StaticMesh'KillingFloorStatics.FT_AmmoMesh'
     CollisionRadius=25.000000
}
