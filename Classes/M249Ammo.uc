class M249Ammo extends KFAmmunition;

#EXEC OBJ LOAD FILE=KillingFloorHUD.utx

defaultproperties
{
     AmmoPickupAmount=60
     MaxAmmo=480
     InitialAmount=180
     PickupClass=Class'ScrnHMG.M249AmmoPickup'
     IconMaterial=Texture'KillingFloorHUD.Generic.HUD'
     IconCoords=(X1=336,Y1=82,X2=382,Y2=125)
     ItemName="Rounds 5.56x45mm NATO"
}
