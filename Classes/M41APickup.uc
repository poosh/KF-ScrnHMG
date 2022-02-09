// secondary pickup required for grenades
class M41APickup extends M41APrimaryPickup;

defaultproperties
{
    PrimaryWeaponPickup=class'M41APrimaryPickup'
    SecondaryAmmoShortName="-- M41A Grenades"
    AmmoCost=20 // nade cost
    BuyClipSize=1
}
