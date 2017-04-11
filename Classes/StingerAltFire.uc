

class StingerAltFire extends KFHighROFFire;


//overrided to disable FlashEmitter attaching to Stinger
simulated function InitEffects()
{
    super(InstantFire).InitEffects();

    // don't even spawn on server
    if ( (Level.NetMode == NM_DedicatedServer) || (AIController(Instigator.Controller) != None) )
		return;
        
    if ( (ShellEjectClass != None) && ((ShellEjectEmitter == None) || ShellEjectEmitter.bDeleteMe) )
    {
        ShellEjectEmitter = Weapon.Spawn(ShellEjectClass);
        Weapon.AttachToBone(ShellEjectEmitter, ShellEjectBoneName);
    }

    // if ( FlashEmitter != None )
        // Weapon.AttachToBone(FlashEmitter, KFWeapon(Weapon).FlashBoneName);
}


//those functions are used only in FireBurst
state FireLoop
{
    function PlayFiring()
    {
        local float RandPitch;

        // don't play fire anim, cuz we already are looping it -- PooSH
        
        // if ( Weapon.Mesh != None )
        // {
            // if ( FireCount > 0 )
            // {
                // if( KFWeap.bAimingRifle )
                // {
                    // if ( Weapon.HasAnim(FireLoopAimedAnim) )
                    // {
                        // Weapon.PlayAnim(FireLoopAimedAnim, FireLoopAnimRate, 0.0);
                    // }
                    // else if( Weapon.HasAnim(FireAimedAnim) )
                    // {
                        // Weapon.PlayAnim(FireAimedAnim, FireAnimRate, TweenTime);
                    // }
                    // else
                    // {
                        // Weapon.PlayAnim(FireAnim, FireAnimRate, TweenTime);
                    // }
                // }
                // else
                // {
                    // if ( Weapon.HasAnim(FireLoopAnim) )
                    // {
                        // Weapon.PlayAnim(FireLoopAnim, FireLoopAnimRate, 0.0);
                    // }
                    // else
                    // {
                        // Weapon.PlayAnim(FireAnim, FireAnimRate, TweenTime);
                    // }
                // }
            // }
            // else
            // {
                // if( KFWeap.bAimingRifle )
                // {
                    // if( Weapon.HasAnim(FireAimedAnim) )
                    // {
                        // Weapon.PlayAnim(FireAimedAnim, FireAnimRate, TweenTime);
                    // }
                    // else
                    // {
                        // Weapon.PlayAnim(FireAnim, FireAnimRate, TweenTime);
                    // }
                // }
                // else
                // {
                    // Weapon.PlayAnim(FireAnim, FireAnimRate, TweenTime);
                // }
            // }
        // }


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
        ClientPlayForceFeedback(FireForce);  // jdf

        FireCount++;
    }
}


defaultproperties
{
    //AmbientFireSound=Sound'HMG_S.Stinger.StingerAltStop'
    FireSoundRef="HMG_S.Stinger.StingerAltStop"
    NoAmmoSoundRef="KF_SCARSnd.SCAR_DryFire"     
     
    RecoilRate=0.075
    maxVerticalRecoilAngle=500
    maxHorizontalRecoilAngle=250
    ShellEjectClass=Class'ROEffects.KFShellEjectSCAR'
    ShellEjectBoneName="Stinger-CordFlap"
    DamageType=Class'ScrnHMG.DamTypeStingerAlt'
    DamageMin=125
    DamageMax=125
    Momentum=25500.000000
    FireAnim="WeaponFire-Secondary"
    FireLoopAnim="WeaponFire-Secondary"
    FireEndAnim="WeaponFireEnd"
    FireRate=0.366667
    FireLoopAnimRate=2.0
    AmmoClass=Class'ScrnHMG.StingerAmmo'
    ShakeRotMag=(X=50.000000,Y=50.000000,Z=300.000000)
    ShakeRotRate=(X=7500.000000,Y=7500.000000,Z=7500.000000)
    ShakeRotTime=0.650000
    ShakeOffsetMag=(X=6.000000,Y=3.000000,Z=7.500000)
    ShakeOffsetRate=(X=1000.000000,Y=1000.000000,Z=1000.000000)
    ShakeOffsetTime=1.150000
    BotRefireRate=0.990000
    FlashEmitterClass=Class'ROEffects.MuzzleFlash1stSPSniper'
    aimerror=42.000000
    Spread=0.05
    SpreadStyle=SS_Random
    AmmoPerFire=3
}