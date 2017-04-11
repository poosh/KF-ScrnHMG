// Inheriting from ScrnVeterancyTypes will include all scrn features -- PooSH
class ScrnVetHeavyMG extends ScrnVeterancyTypes
    abstract;
    
/* General tips:
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
        if ( GetClientVeteranSkillLevel(KFPRI) == 0 )
            InDamage *= 1.05;
        else if ( GetClientVeteranSkillLevel(KFPRI) > 6 )
            InDamage *= (1.50 + 0.05*(GetClientVeteranSkillLevel(KFPRI)-6)); 
        else
            InDamage *= (1.00 + 0.10*fmin(5, GetClientVeteranSkillLevel(KFPRI))); // Up to 50% increase in Damage with smaller guns

        // if ( Injured != none && Injured.default.HealthMax >= 1000 )
            // InDamage *= 0.75; //25% damage reduction on big zeds
    }

    return InDamage;
}
    
static function int AddCarryMaxWeight(KFPlayerReplicationInfo KFPRI)
{
    if ( GetClientVeteranSkillLevel(KFPRI) <= 6 )
        return min(GetClientVeteranSkillLevel(KFPRI)*2, 10); // 2 slots per level, up to 25 @ level 5-6
        
    return 7 + GetClientVeteranSkillLevel(KFPRI)/2; // 1 extra slot per 2 levels above 6
}
    
static function float AddExtraAmmoFor(KFPlayerReplicationInfo KFPRI, Class<Ammunition> AmmoType)
{
    if ( AmmoType == Class'ScrnHMG.AK47HAmmo' 
            || AmmoType == Class'ScrnHMG.SA80LSWAmmo' 
            || AmmoType == Class'ScrnHMG.RPK47Ammo' 
            || AmmoType == Class'ScrnHMG.PKMAmmo' 
            || AmmoType == Class'ScrnHMG.M249Ammo' 
            || AmmoType == Class'ScrnHMG.M41AAmmo' 
            || AmmoType == Class'ScrnHMG.ChainGunAmmo' 
            || AmmoType == Class'ScrnHMG.AUG_A1ARAmmo' 
            || AmmoType == Class'ScrnHMG.StingerAmmo' 
            || AmmoType == Class'ScrnHMG.XMV850Ammo' 
            || AmmoType == Class'ScrnHMG.ThompsonHAmmo' 
            || ClassIsInArray(default.PerkedAmmo, AmmoType) )
    {
        if ( GetClientVeteranSkillLevel(KFPRI) > 6 )
            return 2.0 + 0.10*(GetClientVeteranSkillLevel(KFPRI)-6);            
        else
            return 1.0 + fmin(1.0, 0.20*GetClientVeteranSkillLevel(KFPRI));
    }

    return 1.0;
}    
    
static function float GetMagCapacityModStatic(KFPlayerReplicationInfo KFPRI, class<KFWeapon> Other)
{
    return AddExtraAmmoFor(KFPRI, Other.default.FiremodeClass[0].default.AmmoClass);
}


static function float GetAmmoPickupMod(KFPlayerReplicationInfo KFPRI, KFAmmunition Other)
{
    return AddExtraAmmoFor(KFPRI, Other.class);
}




static function float ModifyRecoilSpread(KFPlayerReplicationInfo KFPRI, WeaponFire Other, out float Recoil)
{
    switch ( GetClientVeteranSkillLevel(KFPRI) ) {
        case 0:
            Recoil = 1.0;
            break;
        case 1:
            Recoil = 0.90;
            break;
        case 2:
            Recoil = 0.85;
            break;
        case 3:
            Recoil = 0.80;
            break;
        case 4:
            Recoil = 0.70;
            break;
        case 5:
            Recoil = 0.60;
            break;
        default:    
            Recoil = 0.50;
    }

    return Recoil;
}

// I'm still thinking it'd better to stick with constant value, e.g. 20%
// Btw, level 8 has no speed penalty at all
// -- PooSH
static function float GetMovementSpeedModifier(KFPlayerReplicationInfo KFPRI, KFGameReplicationInfo KFGRI)
{
    return 0.90;
}



/*
// Set number times Zed Time can be extended
static function int ZedTimeExtensions(KFPlayerReplicationInfo KFPRI)
{
    return Min(GetClientVeteranSkillLevel(KFPRI), 4);
}
*/

// Change the cost of particular items
static function float GetCostScaling(KFPlayerReplicationInfo KFPRI, class<Pickup> Item)
{
    if ( Item == class'ScrnHMG.AK47HPickup' 
            || Item == class'ScrnHMG.SA80LSWPickup' 
            || Item == class'ScrnHMG.RPK47Pickup' 
            || Item == class'ScrnHMG.PKMPickup' 
            || Item == class'ScrnHMG.AUG_A1ARPickup' 
            || Item == class'ScrnHMG.M249Pickup' 
            || Item == class'ScrnHMG.M41APickup' 
            || Item == class'ScrnHMG.ChainGunPickup' 
            || Item == class'ScrnHMG.StingerPickup' 
            || Item == class'ScrnHMG.XMV850Pickup' 
            || Item == class'ScrnHMG.ThompsonHPickup' 
            || ClassIsInArray(default.PerkedPickups, Item) ) 
    {
        if ( GetClientVeteranSkillLevel(KFPRI) <= 6 )
            return 0.9 - 0.10 * float(GetClientVeteranSkillLevel(KFPRI)); // 10% perk level up to 6
        else
            return fmax(0.1, 0.3 - (0.05 * float(GetClientVeteranSkillLevel(KFPRI)-6))); // 5% post level 6
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
            KFHumanPawn(P).CreateInventoryVeterancy("ScrnHMG.SA80LSW", GetInitialCostScaling(KFPRI, class'ScrnHMG.SA80LSWPickup'));
        else if ( GetClientVeteranSkillLevel(KFPRI) == 5 )
            KFHumanPawn(P).CreateInventoryVeterancy("ScrnHMG.AK47H", GetInitialCostScaling(KFPRI, class'ScrnHMG.AK47HPickup'));
    }
}

static function string GetCustomLevelInfo( byte Level )
{
    local string S;
    local byte BonusLevel;

    S = Default.CustomLevelInfo;
    BonusLevel = GetBonusLevel(Level)-6;
    
    ReplaceText(S,"%L",string(BonusLevel+6));
    ReplaceText(S,"%s",GetPercentStr(0.50 + 0.05*BonusLevel));
    ReplaceText(S,"%c",GetPercentStr(1.00 + 0.10*BonusLevel));
    ReplaceText(S,"%d",GetPercentStr(0.7 + fmin(0.2, 0.05*BonusLevel)));
    ReplaceText(S,"%w",string(10 + BonusLevel/2));

    return S;
}

defaultproperties
{
    DefaultDamageType=Class'ScrnHMG.DamTypeHeavy'
    DefaultDamageTypeNoBonus=Class'ScrnHMG.DamTypeHeavyBase' // allows perk progression, but doesn't add damage bonuses

    SRLevelEffects(0)="*** BONUS LEVEL 0 (HMg v3.10)|5% more damage with Heavy Guns|10% less recoil with all guns|10% slower movement speed|10% discount on Heavy Guns"
    SRLevelEffects(1)="*** BONUS LEVEL 1 (HMg v3.10)|10% more damage with Heavy Guns|2 extra weight slots|20% larger Heavy Gun clips|15% less recoil with all guns|10% slower movement speed|20% discount on Heavy Guns"
    SRLevelEffects(2)="*** BONUS LEVEL 2 (HMg v3.10)|20% more damage with Heavy Guns|4 extra weight slots|40% larger Heavy Gun clips|20% less recoil with all guns|10% slower movement speed|30% discount on Heavy Guns"
    SRLevelEffects(3)="*** BONUS LEVEL 3 (HMg v3.10)|30% more damage with Heavy Guns|6 extra weight slots|60% larger Heavy Gun clips|25% less recoil with all guns|10% slower movement speed|40% discount on Heavy Guns"
    SRLevelEffects(4)="*** BONUS LEVEL 4 (HMg v3.10)|40% more damage with Heavy Guns|8 extra weight slots|80% larger Heavy Gun clips|30% less recoil with all guns|10% slower movement speed|50% discount on Heavy Guns"
    SRLevelEffects(5)="*** BONUS LEVEL 5 (HMg v3.10)|50% more damage with Heavy Guns|10 extra weight slots|100% larger Heavy Gun clips|40% less recoil with all guns|10% slower movement speed|60% discount on Heavy Guns|Spawns With AK-47"
    SRLevelEffects(6)="*** BONUS LEVEL 6 (HMg v3.10)|50% more damage with Heavy Guns|10 extra weight slots|100% larger Heavy Gun clips|50% less recoil with all guns|10% slower movement speed|70% discount on Heavy Guns|Spawns With SA-80"
    CustomLevelInfo="*** BONUS LEVEL %L (HMg v3.10)|%s more damage with Heavy Guns|%w extra weight slots|%c larger Heavy Gun clips|50% less recoil with all guns|10% slower movement speed|%d discount on Heavy Guns"

    PerkIndex=10
    OnHUDIcon=Texture'HMG_T.Perks.Perk_HMG'
    OnHUDGoldIcon=Texture'HMG_T.Perks.Perk_HMG_Gold'
    OnHUDIcons(0)=(PerkIcon=Texture'ScrnTex.Perks.Perk_HMG_Gray',StarIcon=Texture'ScrnTex.Perks.Hud_Perk_Star_Gray',DrawColor=(B=255,G=255,R=255,A=255))
    OnHUDIcons(1)=(PerkIcon=Texture'HMG_T.Perks.Perk_HMG_Gold',StarIcon=Texture'KillingFloor2HUD.Perk_Icons.Hud_Perk_Star_Gold',DrawColor=(B=255,G=255,R=255,A=255))
    OnHUDIcons(2)=(PerkIcon=Texture'HMG_T.Perks.Perk_HMG_Green',StarIcon=Texture'ScrnTex.Perks.Hud_Perk_Star_Green',DrawColor=(B=255,G=255,R=255,A=255))
    OnHUDIcons(3)=(PerkIcon=Texture'HMG_T.Perks.Perk_HMG_Blue',StarIcon=Texture'ScrnTex.Perks.Hud_Perk_Star_Blue',DrawColor=(B=255,G=255,R=255,A=255))
    OnHUDIcons(4)=(PerkIcon=Texture'HMG_T.Perks.Perk_HMG_Purple',StarIcon=Texture'ScrnTex.Perks.Hud_Perk_Star_Purple',DrawColor=(B=255,G=255,R=255,A=255))
    OnHUDIcons(5)=(PerkIcon=Texture'HMG_T.Perks.Perk_HMG_Orange',StarIcon=Texture'ScrnTex.Perks.Hud_Perk_Star_Orange',DrawColor=(B=255,G=255,R=255,A=255))    
    OnHUDIcons(6)=(PerkIcon=Texture'ScrnTex.Perks.Perk_HMG_Blood',StarIcon=Texture'ScrnTex.Perks.Hud_Perk_Star_Blood',DrawColor=(B=255,G=255,R=255,A=255))    
    // OnHUDIcons(0)=(PerkIcon=Texture'ScrnTex.Perks.Perk_Brute',StarIcon=Texture'KillingFloorHUD.HUD.Hud_Perk_Star',DrawColor=(B=255,G=255,R=255,A=255))
    // OnHUDIcons(1)=(PerkIcon=Texture'ScrnTex.Perks.Perk_Brute_Gold',StarIcon=Texture'KillingFloor2HUD.Perk_Icons.Hud_Perk_Star_Gold',DrawColor=(B=255,G=255,R=255,A=255))
    // OnHUDIcons(2)=(PerkIcon=Texture'ScrnTex.Perks.Perk_Brute_Green',StarIcon=Texture'ScrnTex.Perks.Hud_Perk_Star_Green',DrawColor=(B=255,G=255,R=255,A=255))
    // OnHUDIcons(3)=(PerkIcon=Texture'ScrnTex.Perks.Perk_Brute_Blue',StarIcon=Texture'ScrnTex.Perks.Hud_Perk_Star_Blue',DrawColor=(B=255,G=255,R=255,A=255))
    // OnHUDIcons(4)=(PerkIcon=Texture'ScrnTex.Perks.Perk_Brute_Purple',StarIcon=Texture'ScrnTex.Perks.Hud_Perk_Star_Purple',DrawColor=(B=255,G=255,R=255,A=255))
    // OnHUDIcons(5)=(PerkIcon=Texture'ScrnTex.Perks.Perk_Brute_Orange',StarIcon=Texture'ScrnTex.Perks.Hud_Perk_Star_Orange',DrawColor=(B=255,G=255,R=255,A=255))    
    
    Requirements(0)="Deal %x damage with Heavy Guns"
    VeterancyName="Heavy Machinegunner"
}
