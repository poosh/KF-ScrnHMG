# KF-ScrnHMG
ScrN Heavy MachineGunner Perk for Killing Floor 1 / ScrN Balance mod

# Instalation
Lines to add in *ScrnBalanceSrv.ini*:
```
CustomPerks=10:ScrnHMG.ScrnVetHeavyMG
SpawnInventory=10:ScrnHMG.AK47HPickup:5:300:150
SpawnInventory=10:ScrnHMG.SA80LSWPickup:6-255:240+60:225
```

Lines to add in *ServerPerks.ini*:
```
Perks=ScrnHMG.ScrnVetHeavyMG
WeaponCategories=10:Heavy Machine Guns
TraderInventory=9:ScrnHMG.AK47Hpickup
TraderInventory=9:ScrnHMG.ThompsonHPickup
TraderInventory=9:ScrnHMG.SA80LSWPickup
TraderInventory=9:ScrnHMG.AUG_A1ARPickup
TraderInventory=9:ScrnHMG.RPK47Pickup
TraderInventory=9:ScrnHMG.XMV850Pickup
TraderInventory=9:ScrnHMG.StingerPickup
TraderInventory=9:ScrnHMG.PKMPickup
TraderInventory=9:ScrnHMG.M249Pickup
TraderInventory=9:ScrnHMG.M41APickup
TraderInventory=9:ScrnHMG.ChainGunPickup
```

# Version History
## Version 5
##### 5.00:
- Fixed Stinger fire sounds
- Adjusted Stinger muzzle flash
- Fixed Pat Chaingun bullet tracer
- AUG A1 weight lowered to 8 (down from 9)
- AUG A1 faster reload: 3.5s -> 2.8s
- SA80 weight lowered to 7 (down from 11)
- SA80 can slightly damage heads (HS mult. 0.3)
- RPK47 weight raised to 9 (up from 8)
- Added bullet penetration for RPK47, PKM and M249


## Version 2
##### 2.10:
- M41A price set back to $9999

##### 2.07:
- M41A's 3rd person mesh temporary changed to M4-203 to check crashing

##### 2.06:
- Fixed XMB850 attachment's shell ejector
- Another try to fix M41A crash


##### 2.03:
- XMV850 base damage lowered down to 39 (58 perked @ L6)
- Probably fixed M41A crash
- Added BDFonts.utx to the release package

## Initial release (2.0)
Heavy Machine Gunner (HMg) changes comparing to Brute Gunner PNW:
- New weapon: XMV850 Minigun
- Stinger now really shoots 2000RPM (fixed server tickrate limitation)
- Pat's Chaingun has x1.5 bigger clip and up to 5 rockets
- Modified weapon weighs and prices
