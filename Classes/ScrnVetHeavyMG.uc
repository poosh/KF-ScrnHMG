// Inheriting from ScrnVeterancyTypes will include all scrn features -- PooSH
class ScrnVetHeavyMG extends ScrnVeterancyTypes
    abstract;

/* General tips for making perks ScrN-compatible:
- ScrnBalanceSrv must be added to EditPackages in KillingFloor.ini
- Replaced all KFPRI.ClientVeteranSkillLevel with GetClientVeteranSkillLevel(KFPRI)
- GetMagCapacityMod() replaced with GetMagCapacityModStatic()
- GetReloadSpeedModifier() replaced with GetReloadSpeedModifierStatic()
- GetFireSpeedMod() replaced with GetFireSpeedModStatic()
- Added ClassIsInArray() calls to support PerkedWeapons
- Removed AddDefaultInventory() to support SpawnInventory
*/


// returns perk specific stat values
static function int GetStatValueInt(ClientPerkRepLink StatOther, byte ReqNum)
{
    return StatOther.GetCustomValueInt(Class'BruteGunnerPerkProg');
}

static function AddCustomStats( ClientPerkRepLink Other )
{
    super.AddCustomStats(Other); //init achievements

    Other.AddCustomValue(Class'BruteGunnerPerkProg');
}


static function int AddDamage(KFPlayerReplicationInfo KFPRI, KFMonster Injured, KFPawn DamageTaker, int InDamage, class<DamageType> DmgType)
{
    if ( DmgType == default.DefaultDamageTypeNoBonus )
        return InDamage;

    if ( ClassIsChildOf(DmgType, default.DefaultDamageType)
            || ClassIsInArray(default.PerkedDamTypes, DmgType) // check damage type list of custom weapons
        )
    {
        // 30% base bonus + 5% per level
        InDamage *= 1.30 + 0.05 * GetClientVeteranSkillLevel(KFPRI);
    }

    return InDamage;
}

static function int AddCarryMaxWeight(KFPlayerReplicationInfo KFPRI)
{
    return 10;
}

static function float AddExtraAmmoFor(KFPlayerReplicationInfo KFPRI, Class<Ammunition> AmmoType)
{
    if ( AmmoType == class'SA80LSWAmmo'
            || AmmoType == class'RPK47Ammo'
            || AmmoType == class'PKMAmmo'
            || AmmoType == class'M249Ammo'
            || AmmoType == class'M41AAmmo'
            || AmmoType == class'ChainGunAmmo'
            || AmmoType == class'AUG_A1ARAmmo'
            || AmmoType == class'StingerAmmo'
            || AmmoType == class'XMV850Ammo'
            || AmmoType == class'ThompsonHAmmo'
            || ClassIsInArray(default.PerkedAmmo, AmmoType) )
    {
        return 1.4 + 0.10 * GetClientVeteranSkillLevel(KFPRI);
    }
    return 1.0;
}

static function float GetMagCapacityModStatic(KFPlayerReplicationInfo KFPRI, class<KFWeapon> Other)
{
    return fmin(2.0, AddExtraAmmoFor(KFPRI, Other.default.FiremodeClass[0].default.AmmoClass));
}

static function float GetAmmoPickupMod(KFPlayerReplicationInfo KFPRI, KFAmmunition Other)
{
    return AddExtraAmmoFor(KFPRI, Other.class);
}

static function float ModifyRecoilSpread(KFPlayerReplicationInfo KFPRI, WeaponFire Other, out float Recoil)
{
    Recoil = 0.25;
    return Recoil;
}

static function float GetMovementSpeedModifier(KFPlayerReplicationInfo KFPRI, KFGameReplicationInfo KFGRI)
{
    return 0.90;
}

static function float GetCostScaling(KFPlayerReplicationInfo KFPRI, class<Pickup> Item)
{
    if ( Item == class'SA80LSWPickup'
            || Item == class'RPK47Pickup'
            || Item == class'PKMPickup'
            || Item == class'AUG_A1ARPickup'
            || Item == class'M249Pickup'
            || Item == class'M41APickup'
            || Item == class'ChainGunPickup'
            || Item == class'StingerPickup'
            || Item == class'XMV850Pickup'
            || Item == class'ThompsonHPickup'
            || ClassIsInArray(default.PerkedPickups, Item) )
    {
        // 30% base discount + 5% extra per level
        return fmax(0.10, 0.70 - 0.05 * GetClientVeteranSkillLevel(KFPRI));
    }

    return 1.0;
}

// Give Extra Items as default
static function AddDefaultInventory(KFPlayerReplicationInfo KFPRI, Pawn P)
{
    if ( default.DefaultInventory.length > 0 )
        super.AddDefaultInventory(KFPRI, P); // ScrnBalance v6.10+
    else {
        // old style
        if ( GetClientVeteranSkillLevel(KFPRI) >= 6 )
            KFHumanPawn(P).CreateInventoryVeterancy(string(class'SA80LSW'), GetInitialCostScaling(KFPRI, class'SA80LSWPickup'));
        else if ( GetClientVeteranSkillLevel(KFPRI) == 5 )
            KFHumanPawn(P).CreateInventoryVeterancy(string(class'ThompsonH'), GetInitialCostScaling(KFPRI, class'ThompsonHPickup'));
    }
}

static function string GetCustomLevelInfo( byte Level )
{
    local string S;

    S = Default.CustomLevelInfo;
    ReplaceText(S,"%L",string(Level));
    ReplaceText(S,"%x",GetPercentStr(0.30 + 0.05*Level));
    ReplaceText(S,"%m",GetPercentStr(0.40 + 0.10*Level));
    ReplaceText(S,"%a",GetPercentStr(0.40 + 0.10*Level));
    ReplaceText(S,"%$",GetPercentStr(fmin(0.90, 0.30 + 0.05*Level)));
    return S;
}

defaultproperties
{
    DefaultDamageType=class'DamTypeHeavy'
    DefaultDamageTypeNoBonus=class'DamTypeHeavyBase' // allows perk progression, but doesn't add damage bonuses

    SkillInfo="PERK SKILLS:|75% less recoil with all guns|10 extra weight slots|10% slower movement"
    CustomLevelInfo="PERK BONUSES (LEVEL %L):|%x more damage with Heavy Guns|%m larger Heavy Gun clips|%a extra Heavy ammo|%$ discount on Heavy Guns"

    PerkIndex=10
    OnHUDIcon=Texture'HMG_T.Perks.Perk_HMG'
    OnHUDGoldIcon=Texture'HMG_T.Perks.Perk_HMG_Gold'
    OnHUDIcons(0)=(PerkIcon=Texture'ScrnTex.Perks.Perk_HMG_Gray',StarIcon=Texture'ScrnTex.Perks.Hud_Perk_Star_Gray',DrawColor=(B=255,G=255,R=255,A=255))
    OnHUDIcons(1)=(PerkIcon=Texture'ScrnTex.Perks.Perk_HMG_Gold',StarIcon=Texture'ScrnTex.Perks.Hud_Perk_Star_Gold',DrawColor=(B=255,G=255,R=255,A=255))
    OnHUDIcons(2)=(PerkIcon=Texture'ScrnTex.Perks.Perk_HMG_Green',StarIcon=Texture'ScrnTex.Perks.Hud_Perk_Star_Green',DrawColor=(B=255,G=255,R=255,A=255))
    OnHUDIcons(3)=(PerkIcon=Texture'ScrnTex.Perks.Perk_HMG_Blue',StarIcon=Texture'ScrnTex.Perks.Hud_Perk_Star_Blue',DrawColor=(B=255,G=255,R=255,A=255))
    OnHUDIcons(4)=(PerkIcon=Texture'ScrnTex.Perks.Perk_HMG_Purple',StarIcon=Texture'ScrnTex.Perks.Hud_Perk_Star_Purple',DrawColor=(B=255,G=255,R=255,A=255))
    OnHUDIcons(5)=(PerkIcon=Texture'ScrnTex.Perks.Perk_HMG_Orange',StarIcon=Texture'ScrnTex.Perks.Hud_Perk_Star_Orange',DrawColor=(B=255,G=255,R=255,A=255))
    OnHUDIcons(6)=(PerkIcon=Texture'ScrnTex.Perks.Perk_HMG_Blood',StarIcon=Texture'ScrnTex.Perks.Hud_Perk_Star_Blood',DrawColor=(B=255,G=255,R=255,A=255))
    // OnHUDIcons(0)=(PerkIcon=Texture'ScrnTex.Perks.Perk_Brute',StarIcon=Texture'KillingFloorHUD.HUD.Hud_Perk_Star',DrawColor=(B=255,G=255,R=255,A=255))
    // OnHUDIcons(1)=(PerkIcon=Texture'ScrnTex.Perks.Perk_Brute_Gold',StarIcon=Texture'KillingFloor2HUD.Perk_Icons.Hud_Perk_Star_Gold',DrawColor=(B=255,G=255,R=255,A=255))
    // OnHUDIcons(2)=(PerkIcon=Texture'ScrnTex.Perks.Perk_Brute_Green',StarIcon=Texture'ScrnTex.Perks.Hud_Perk_Star_Green',DrawColor=(B=255,G=255,R=255,A=255))
    // OnHUDIcons(3)=(PerkIcon=Texture'ScrnTex.Perks.Perk_Brute_Blue',StarIcon=Texture'ScrnTex.Perks.Hud_Perk_Star_Blue',DrawColor=(B=255,G=255,R=255,A=255))
    // OnHUDIcons(4)=(PerkIcon=Texture'ScrnTex.Perks.Perk_Brute_Purple',StarIcon=Texture'ScrnTex.Perks.Hud_Perk_Star_Purple',DrawColor=(B=255,G=255,R=255,A=255))
    // OnHUDIcons(5)=(PerkIcon=Texture'ScrnTex.Perks.Perk_Brute_Orange',StarIcon=Texture'ScrnTex.Perks.Hud_Perk_Star_Orange',DrawColor=(B=255,G=255,R=255,A=255))

    Requirements(0)="Deal %x damage with Heavy Guns"
    VeterancyName="Heavy Machinegunner"
    ShortName="HMG"
}
