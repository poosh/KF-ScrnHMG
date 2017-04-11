//=============================================================================
// LAW Ammo.
//=============================================================================
class Rocketammo extends KFAmmunition;

#EXEC OBJ LOAD FILE=KillingFloorHUD.utx

defaultproperties
{
     AmmoPickupAmount=1
     MaxAmmo=5
     InitialAmount=1
     PickupClass=Class'ScrnHMG.RocketAmmoPickup'
     IconMaterial=Texture'KillingFloorHUD.Generic.HUD'
     IconCoords=(X1=458,Y1=34,X2=511,Y2=78)
     ItemName="L.A.W Rockets"
}
