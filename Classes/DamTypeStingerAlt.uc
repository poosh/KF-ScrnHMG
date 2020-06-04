class DamTypeStingerAlt extends DamTypeHeavy
    abstract;

defaultproperties
{
     WeaponClass=Class'ScrnHMG.Stinger'
     DeathString="%k killed %o (Stinger)."
     FemaleSuicide="%o shot herself in the foot."
     MaleSuicide="%o shot himself in the foot."
     bRagdollBullet=True
     bBulletHit=True
     DeathOverlayMaterial=Combiner'Effects_Tex.GoreDecals.PlayerDeathOverlay'
     DeathOverlayTime=999.000000
     KDamageImpulse=15000.000000
     KDeathVel=1500.000000
     KDeathUpKick=150.000000
}
