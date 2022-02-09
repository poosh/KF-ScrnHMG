class MuzzleFlashM41A extends ROMuzzleFlash1st;

simulated function Trigger(Actor Other, Pawn EventInstigator)
{
    Emitters[0].SpawnParticle(2);
    Emitters[1].SpawnParticle(1);
    Emitters[2].SpawnParticle(1);
    Emitters[3].SpawnParticle(1);
}

defaultproperties
{
     Begin Object Class=SpriteEmitter Name=SpriteEmitter22
         UseColorScale=True
         FadeOut=True
         RespawnDeadParticles=False
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         BlendBetweenSubdivisions=True
         UseSubdivisionScale=True
         ColorScale(0)=(Color=(B=255,G=255,R=255,A=255))
         ColorScale(1)=(RelativeTime=1.000000,Color=(B=187,G=252,R=255,A=255))
         FadeOutStartTime=0.046740
         CoordinateSystem=PTCS_Relative
         MaxParticles=2
         SpinsPerSecondRange=(X=(Min=0.437000,Max=0.573000))
         StartSpinRange=(X=(Max=1.000000))
         SizeScale(1)=(RelativeTime=1.000000,RelativeSize=0.820000)
         StartSizeRange=(X=(Min=11.518997,Max=31.999001))
         Texture=Texture'HMG_T.M41A.fx.Muzzle1'
         TextureUSubdivisions=2
         TextureVSubdivisions=1
         SubdivisionScale(0)=0.900000
         SubdivisionScale(1)=0.100000
         SubdivisionScale(2)=0.001000
         LifetimeRange=(Min=0.057000,Max=0.057000)
     End Object
     Emitters(0)=SpriteEmitter22

     Begin Object Class=SpriteEmitter Name=SpriteEmitter20
         RespawnDeadParticles=False
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         BlendBetweenSubdivisions=True
         UseSubdivisionScale=True
         ColorMultiplierRange=(X=(Min=0.760000,Max=0.760000),Y=(Min=0.692000,Max=0.760000),Z=(Min=0.638000,Max=0.638000))
         CoordinateSystem=PTCS_Relative
         MaxParticles=2
         SpinsPerSecondRange=(X=(Min=0.387000,Max=0.495000))
         StartSpinRange=(X=(Max=1.000000))
         SizeScale(1)=(RelativeTime=0.370000,RelativeSize=0.757000)
         SizeScale(2)=(RelativeTime=1.000000,RelativeSize=1.000000)
         StartSizeRange=(X=(Min=11.122002,Max=31.122002))
         Texture=Texture'HMG_T.M41A.fx.Muzzle1'
         TextureUSubdivisions=2
         TextureVSubdivisions=1
         SubdivisionScale(0)=0.900000
         SubdivisionScale(1)=0.100000
         SubdivisionScale(2)=0.001000
         LifetimeRange=(Min=0.057000,Max=0.057000)
     End Object
     Emitters(1)=SpriteEmitter20

     Begin Object Class=SpriteEmitter Name=SpriteEmitter21
         FadeOut=True
         RespawnDeadParticles=False
         SpinParticles=True
         UseSizeScale=True
         UseRegularSizeScale=False
         UniformSize=True
         AutomaticInitialSpawning=False
         BlendBetweenSubdivisions=True
         UseSubdivisionScale=True
         ColorMultiplierRange=(X=(Min=0.900000,Max=0.900000),Y=(Min=0.800000,Max=0.900000),Z=(Min=0.704000,Max=0.704000))
         FadeOutStartTime=0.003120
         CoordinateSystem=PTCS_Relative
         MaxParticles=9
         StartLocationRange=(Y=(Min=-7.535000,Max=7.535000),Z=(Min=-7.535000,Max=7.535000))
         SpinsPerSecondRange=(X=(Min=0.025000,Max=0.035000))
         StartSpinRange=(X=(Max=1.000000))
         SizeScale(0)=(RelativeSize=0.100000)
         SizeScale(1)=(RelativeTime=0.280000,RelativeSize=1.126000)
         SizeScale(2)=(RelativeTime=1.000000,RelativeSize=0.870000)
         StartSizeRange=(X=(Min=13.900000,Max=16.318001))
         Texture=Texture'HMG_T.M41A.fx.Muzzle1'
         TextureUSubdivisions=2
         TextureVSubdivisions=1
         SubdivisionScale(0)=0.900000
         SubdivisionScale(1)=0.100000
         SubdivisionScale(2)=0.001000
         LifetimeRange=(Min=0.052000,Max=0.052000)
     End Object
     Emitters(2)=SpriteEmitter21

     Begin Object Class=SpriteEmitter Name=SpriteEmitter0
         RespawnDeadParticles=False
         UniformSize=True
         AutomaticInitialSpawning=False
         Opacity=0.100000
         MaxParticles=1
         StartSizeRange=(X=(Min=50.000000,Max=50.000000))
         DrawStyle=PTDS_Brighten
         Texture=Texture'Effects_Tex.Smoke.MuzzleCorona1stP'
         LifetimeRange=(Min=0.100000,Max=0.100000)
     End Object
     Emitters(3)=SpriteEmitter0

}
