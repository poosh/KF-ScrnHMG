class DamTypeCG extends DamTypeHeavy
    abstract;


defaultproperties
{
     WeaponClass=Class'ScrnHMG.ChainGun'
     DeathString="%k killed %o (Pat's Chain Gun)."
     FemaleSuicide="%o shot herself in the foot."
     MaleSuicide="%o shot himself in the foot."
     bRagdollBullet=True
     bBulletHit=True
     DeathOverlayMaterial=Combiner'Effects_Tex.GoreDecals.PlayerDeathOverlay'
     DeathOverlayTime=999.000000
     KDamageImpulse=14500.000000
     KDeathVel=1500.000000
     KDeathUpKick=200.000000
     VehicleDamageScaling=0.700000
}
