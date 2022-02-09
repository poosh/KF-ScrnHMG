class DamTypeM41AAssaultRifle extends DamTypeHeavy
    abstract;

defaultproperties
{
     WeaponClass=class'M41AAssaultRifle'
     DeathString="%k killed %o (Pulse Rifle)."
     FemaleSuicide="%o shot herself in the foot."
     MaleSuicide="%o shot himself in the foot."
     bRagdollBullet=True
     bBulletHit=True
     DeathOverlayMaterial=Combiner'Effects_Tex.GoreDecals.PlayerDeathOverlay'
     DeathOverlayTime=999.000000
     KDamageImpulse=13500.000000
     KDeathVel=1400.000000
     KDeathUpKick=150.000000
     VehicleDamageScaling=0.700000
}
