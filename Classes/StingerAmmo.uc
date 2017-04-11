class StingerAmmo extends KFAmmunition;

#EXEC OBJ LOAD FILE=KillingFloorHUD.utx

defaultproperties
{
     PickupClass=Class'ScrnHMG.StingerAmmoPickup'
     IconMaterial=Texture'KillingFloorHUD.Generic.HUD'
     IconCoords=(X1=336,Y1=82,X2=382,Y2=125)
     
     // *** Modifications belowe made by [ScrN]PooSH ***
     ItemName="Tarydium Crystals"
     AmmoPickupAmount=123
     MaxAmmo=861
     InitialAmount=369
}
