class DamTypeM249SAW extends DamTypeHeavy
	abstract;

defaultproperties
{
     WeaponClass=Class'ScrnHMG.M249SAW'
     DeathString="%k killed %o (M249 SAW)."
     FemaleSuicide="%o shot herself in the foot."
     MaleSuicide="%o shot himself in the foot."
     bRagdollBullet=True
     bBulletHit=True
     DeathOverlayMaterial=Combiner'Effects_Tex.GoreDecals.PlayerDeathOverlay'
     DeathOverlayTime=999.000000
     KDamageImpulse=12500.000000
     KDeathVel=1200.000000
     KDeathUpKick=125.000000
     VehicleDamageScaling=0.700000
}
