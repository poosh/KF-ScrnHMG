class M41AALTFire extends KFShotgunFire;


var()   name    FireLastAnim;
var()   name    FireLastAimedAnim;
var()   float   FireLastRate;

var()   Emitter     Flash2Emitter;
var()   name        MuzzleBoneLeft;
var()   name        MuzzleBoneRight;
/*

simulated function InitEffects()
{
    // don't even spawn on server
    if ( (Level.NetMode == NM_DedicatedServer) || (AIController(Instigator.Controller) != None) )
        return;
    if ( (FlashEmitterClass != None) && ((FlashEmitter == None) || FlashEmitter.bDeleteMe) )
    {
        FlashEmitter = Weapon.Spawn(FlashEmitterClass);
        Weapon.AttachToBone(FlashEmitter, MuzzleBoneLeft);
    }
    if ( (FlashEmitterClass != None) && ((Flash2Emitter == None) || Flash2Emitter.bDeleteMe) )
    {
        Flash2Emitter = Weapon.Spawn(FlashEmitterClass);
        Weapon.AttachToBone(Flash2Emitter, MuzzleBoneRight);
    }

    if ( (SmokeEmitterClass != None) && ((SmokeEmitter == None) || SmokeEmitter.bDeleteMe) )
    {
        SmokeEmitter = Weapon.Spawn(SmokeEmitterClass);
    }
}

simulated function DestroyEffects()
{
    super.DestroyEffects();

    if (Flash2Emitter != None)
        Flash2Emitter.Destroy();
}

function FlashMuzzleFlash()
{
    if( KFWeap.MagAmmoRemaining == 2)
    {
        if (Flash2Emitter != None)
            Flash2Emitter.Trigger(Weapon, Instigator);
    }
    else
    {
        if (FlashEmitter != None)
            FlashEmitter.Trigger(Weapon, Instigator);
    }
}

*/
simulated function bool AllowFire()
{


            return ( Weapon.AmmoAmount(ThisModeNum) >= AmmoPerFire);
}

// Overridden to support special anim functionality of the double barreled shotgun
function PlayFiring()
{
    local float RandPitch;

    if ( Weapon == none )
        return;

    if ( Weapon.Mesh != None )
    {
        if ( FireCount > 0 )
        {
            if( KFWeap.bAimingRifle )
            {
                if ( Weapon.HasAnim(FireLoopAimedAnim) )
                {
                    Weapon.PlayAnim(FireLoopAimedAnim, FireLoopAnimRate, 0.0);
                }
                else if( Weapon.HasAnim(FireAimedAnim) )
                {
                    Weapon.PlayAnim(FireAimedAnim, FireAnimRate, TweenTime);
                }
                else
                {
                    Weapon.PlayAnim(FireAnim, FireAnimRate, TweenTime);
                }
            }
            else
            {
                if ( Weapon.HasAnim(FireLoopAnim) )
                {
                    Weapon.PlayAnim(FireLoopAnim, FireLoopAnimRate, 0.0);
                }
                else
                {
                    Weapon.PlayAnim(FireAnim, FireAnimRate, TweenTime);
                }
            }
        }
        else
        {
            if( KFWeap.bAimingRifle )
            {
                if( BoomStick(Weapon).SingleShotCount == 0 && Weapon.HasAnim(FireLastAimedAnim))
                {
                    Weapon.PlayAnim(FireLastAimedAnim, FireAnimRate, TweenTime);
                }
                else if( Weapon.HasAnim(FireAimedAnim) )
                {
                    Weapon.PlayAnim(FireAimedAnim, FireAnimRate, TweenTime);
                }
                else
                {
                    Weapon.PlayAnim(FireAnim, FireAnimRate, TweenTime);
                }
            }
            else
            {
                if( BoomStick(Weapon).SingleShotCount == 0 && Weapon.HasAnim(FireLastAnim))
                {
                    Weapon.PlayAnim(FireLastAnim, FireAnimRate, TweenTime);
                }
                else
                {
                    Weapon.PlayAnim(FireAnim, FireAnimRate, TweenTime);
                }
            }
        }
    }
    if( Weapon.Instigator != none && Weapon.Instigator.IsLocallyControlled() &&
       Weapon.Instigator.IsFirstPerson() && StereoFireSound != none )
    {
        if( bRandomPitchFireSound )
        {
            RandPitch = FRand() * RandomPitchAdjustAmt;

            if( FRand() < 0.5 )
            {
                RandPitch *= -1.0;
            }
        }

        Weapon.PlayOwnedSound(StereoFireSound,SLOT_Interact,TransientSoundVolume * 0.85,,TransientSoundRadius,(1.0 + RandPitch),false);
    }
    else
    {
        if( bRandomPitchFireSound )
        {
            RandPitch = FRand() * RandomPitchAdjustAmt;

            if( FRand() < 0.5 )
            {
                RandPitch *= -1.0;
            }
        }

        Weapon.PlayOwnedSound(FireSound,SLOT_Interact,TransientSoundVolume,,TransientSoundRadius,(1.0 + RandPitch),false);
    }


    
    if ( FireCount > 2 )
       {
                     Weapon.PlayAnim(ReloadAnim, ReloadAnimRate, TweenTime);
       }        
   
    ClientPlayForceFeedback(FireForce);  // jdf

    FireCount++;

}



//=====================================================================================================
//=====================================================================================================
//==
//==        D E F A U L T P R O P E R T I E S
//==
//=====================================================================================================
//=====================================================================================================

defaultproperties
{
     FireSoundRef="KF_M32Snd.M32_Fire"
     StereoFireSoundRef="KF_M32Snd.M32_FireST"
     NoAmmoSoundRef="KF_M79Snd.M79_DryFire"

     EffectiveRange=2500.000000
     maxVerticalRecoilAngle=200
     maxHorizontalRecoilAngle=50
     ProjPerFire=1
     ProjSpawnOffset=(X=50.000000,Y=10.000000)
     bFireOnRelease=True
     bWaitForRelease=True
     TransientSoundVolume=1.800000
     FireAnim="AltFire"
     FireForce="AssaultRifleFire"
     FireRate=1.250000
     AmmoClass=class'M41AProjectileAmmo'
     ShakeRotMag=(X=3.000000,Y=4.000000,Z=2.000000)
     ShakeRotRate=(X=10000.000000,Y=10000.000000,Z=10000.000000)
     ShakeOffsetMag=(X=3.000000,Y=3.000000,Z=3.000000)
     ProjectileClass=Class'KFMod.M203GrenadeProjectile'
     BotRefireRate=1.800000
     FlashEmitterClass=Class'ROEffects.MuzzleFlash1stNadeL'
     aimerror=42.000000
     Spread=0.015000
}
