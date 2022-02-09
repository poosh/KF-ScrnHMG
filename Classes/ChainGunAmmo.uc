// HuskGunAmmo
//=============================================================================
// Ammo for the Husk Gun primary fire
//=============================================================================
// Killing Floor Source
// Copyright (C) 2011 Tripwire Interactive LLC
// - John "Ramm-Jaeger" Gibson
//=============================================================================
class ChainGunAmmo extends KFAmmunition;

defaultproperties
{
     AmmoPickupAmount=150
     MaxAmmo=750
     InitialAmount=300
     PickupClass=class'ChainGunAmmoPickup'
     IconMaterial=Texture'KillingFloorHUD.Generic.HUD'
     IconCoords=(X1=4,Y1=350,X2=110,Y2=395)
     ItemName="Chaingun bullets"
}
