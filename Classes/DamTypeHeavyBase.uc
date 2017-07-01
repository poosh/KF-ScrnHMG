// Heavy Machinegunner's base damage type
class DamTypeHeavyBase extends ScrnDamTypeHeavyBase
    abstract;

static function AwardDamage(KFSteamStatsAndAchievements KFStatsAndAchievements, int Amount)
{
    if( SRStatsBase(KFStatsAndAchievements)!=None && SRStatsBase(KFStatsAndAchievements).Rep!=None )
        SRStatsBase(KFStatsAndAchievements).Rep.ProgressCustomValue(Class'BruteGunnerPerkProg',Amount);
}

defaultproperties
{
    bCheckForHeadShots=false
}
