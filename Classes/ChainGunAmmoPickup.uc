//=============================================================================
// HuskGunAmmoPickup
//=============================================================================
// Ammo pickup class for the Husk Gun primary fire
//=============================================================================
// Killing Floor Source
// Copyright (C) 2011 Tripwire Interactive LLC
// - John "Ramm-Jaeger" Gibson
//=============================================================================
class ChainGunAmmoPickup extends KFAmmoPickup;

defaultproperties
{
     AmmoAmount=100
     InventoryType=Class'ScrnHMG.ChainGunAmmo'
     PickupMessage="Chaingun Bullets"
     StaticMesh=StaticMesh'KillingFloorStatics.FT_AmmoMesh'
     CollisionRadius=25.000000
}
