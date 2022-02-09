//=============================================================================
// SCARMK17 Ammo.
//=============================================================================
class M41AAmmo extends KFAmmunition;

#EXEC OBJ LOAD FILE=KillingFloorHUD.utx

defaultproperties
{
     AmmoPickupAmount=33
     MaxAmmo=264
     InitialAmount=132
     PickupClass=class'M41AAmmoPickup'
     IconMaterial=Texture'KillingFloorHUD.Generic.HUD'
     IconCoords=(X1=336,Y1=82,X2=382,Y2=125)
     ItemName="M41A 10 mm caseless ammunition"
}
