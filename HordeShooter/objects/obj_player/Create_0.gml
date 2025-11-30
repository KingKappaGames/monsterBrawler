event_inherited();

HealthMax = 100;
Health = HealthMax;

hspeed = 0;
vspeed = 0;
speedDecay = .78;
speedDecayAir = .91;

heightChange = 0;
height = 0;
bounceHorizontalSpeedtMult = .8;
bounceHeightMult = -.4;

moveSpeed = 1.6;
moveSpeedAir = .6;

jumpSpeed = 4.2;
knockbackMult = 1;

canMove = true;
intangible = false; // cannot be hit or affected by effects (different than i frames i think?)

directionFacing = choose(-1, 1);

poiseMax = 80;
poise = poiseMax;

meleeDamage = 5;

allegiance = E_allegiance.player;

#region animations
useSkeletonAnimations = true;

//skeletonBasicItem = choose(spr_swordBranch, spr_swordHammer, spr_swordIce, spr_swordSpear);
	item = undefined;
	script_equipItem(script_getItemInfo(E_item.toyHammer),, false);
	skeletonBasicItem = item.sprite;
	skeletonBasicHandRightSprite = spr_handGlove;
	skeletonBasicHandLeftSprite = spr_handGlove;
	skeletonBasicHeadSprite = spr_eskimoHead;
	skeletonBasicBodySprite = spr_eskimoBody;

	skeletonData = [
			[ [ [skeletonBasicItem, 0], [skeletonBasicHandRightSprite, 0], [skeletonBasicHandLeftSprite, 0], [skeletonBasicHeadSprite, 0], [skeletonBasicBodySprite, 0], [spr_flameMonsterLegsIdle, 0] ],
			  [ [skeletonBasicItem, 0], [skeletonBasicHandRightSprite, 0], [skeletonBasicHandLeftSprite, 0], [skeletonBasicHeadSprite, 0], [skeletonBasicBodySprite, 0], [spr_flameMonsterLegsIdle, 1] ], ],
			[ [ [skeletonBasicItem, 0], [skeletonBasicHandRightSprite, 0], [skeletonBasicHandLeftSprite, 0], [skeletonBasicHeadSprite, 0], [skeletonBasicBodySprite, 0], [spr_flameMonsterLegsRun, 0] ],
			  [ [skeletonBasicItem, 0], [skeletonBasicHandRightSprite, 0], [skeletonBasicHandLeftSprite, 0], [skeletonBasicHeadSprite, 0], [skeletonBasicBodySprite, 0], [spr_flameMonsterLegsRun, 1] ],
			  [ [skeletonBasicItem, 0], [skeletonBasicHandRightSprite, 0], [skeletonBasicHandLeftSprite, 0], [skeletonBasicHeadSprite, 0], [skeletonBasicBodySprite, 0], [spr_flameMonsterLegsRun, 2] ],
			  [ [skeletonBasicItem, 0], [skeletonBasicHandRightSprite, 0], [skeletonBasicHandLeftSprite, 0], [skeletonBasicHeadSprite, 0], [skeletonBasicBodySprite, 0], [spr_flameMonsterLegsRun, 3] ], ],
			[ [ [-1, 0], [-1, 0], [skeletonBasicHandLeftSprite, 0], [skeletonBasicHeadSprite, 0], [skeletonBasicBodySprite, 0], [spr_flameMonsterLegsHit, 0] ],
			  [ [-1, 0], [-1, 0], [skeletonBasicHandLeftSprite, 0], [skeletonBasicHeadSprite, 0], [skeletonBasicBodySprite, 0], [spr_flameMonsterLegsHit, 1] ],
			  [ [-1, 0], [-1, 0], [skeletonBasicHandLeftSprite, 0], [skeletonBasicHeadSprite, 0], [skeletonBasicBodySprite, 0], [spr_flameMonsterLegsHit, 2] ],
			  [ [-1, 0], [-1, 0], [skeletonBasicHandLeftSprite, 0], [skeletonBasicHeadSprite, 0], [skeletonBasicBodySprite, 0], [spr_flameMonsterLegsHit, 3] ],
			  [ [-1, 0], [-1, 0], [skeletonBasicHandLeftSprite, 0], [skeletonBasicHeadSprite, 0], [skeletonBasicBodySprite, 0], [spr_flameMonsterLegsHit, 4] ], ],
			[ [ [skeletonBasicItem, 0], [skeletonBasicHandRightSprite, 0], [skeletonBasicHandLeftSprite, 0], [skeletonBasicHeadSprite, 0], [skeletonBasicBodySprite, 0], [spr_flameMonsterLegsJumpStart, 0] ],
			  [ [skeletonBasicItem, 0], [skeletonBasicHandRightSprite, 0], [skeletonBasicHandLeftSprite, 0], [skeletonBasicHeadSprite, 0], [skeletonBasicBodySprite, 0], [spr_flameMonsterLegsJumpStart, 1] ],
			  [ [skeletonBasicItem, 0], [skeletonBasicHandRightSprite, 0], [skeletonBasicHandLeftSprite, 0], [skeletonBasicHeadSprite, 0], [skeletonBasicBodySprite, 0], [spr_flameMonsterLegsJumpStart, 2] ],
			  [ [skeletonBasicItem, 0], [skeletonBasicHandRightSprite, 0], [skeletonBasicHandLeftSprite, 0], [skeletonBasicHeadSprite, 0], [skeletonBasicBodySprite, 0], [spr_flameMonsterLegsJumpStart, 3] ], ],
			[ [ [skeletonBasicItem, 0], [skeletonBasicHandRightSprite, 0], [skeletonBasicHandLeftSprite, 0], [skeletonBasicHeadSprite, 0], [skeletonBasicBodySprite, 0], [spr_flameMonsterLegsJumpRise, 0] ],
			  [ [skeletonBasicItem, 0], [skeletonBasicHandRightSprite, 0], [skeletonBasicHandLeftSprite, 0], [skeletonBasicHeadSprite, 0], [skeletonBasicBodySprite, 0], [spr_flameMonsterLegsJumpRise, 1] ], ],
			[ [ [skeletonBasicItem, 0], [skeletonBasicHandRightSprite, 0], [skeletonBasicHandLeftSprite, 0], [skeletonBasicHeadSprite, 0], [skeletonBasicBodySprite, 0], [spr_flameMonsterLegsJumpFall, 0] ],
			  [ [skeletonBasicItem, 0], [skeletonBasicHandRightSprite, 0], [skeletonBasicHandLeftSprite, 0], [skeletonBasicHeadSprite, 0], [skeletonBasicBodySprite, 0], [spr_flameMonsterLegsJumpFall, 1] ], ],
	]
#endregion

deathSound = snd_crunch;

var sec = game_get_speed(gamespeed_fps)

spreadMinimum = 0;
spread = 3;
spreadDecay = .97;

directionAiming = 0;
recoil = 0;

mortaring = 0;
mortarXstart = 0;
mortarYstart = 0;

cameraOne = camera_create_view(0, 0, 960, 540);
view_set_camera(0, cameraOne); //view_camera[0] or [1] worked

view_enabled = true;
view_visible[0] = true;

surface_resize(application_surface, 1920, 1080);
window_set_size(1920, 1080);

view_wport[0] = 1920;
view_hport[0] = 1080;

global.cam = view_camera[0];

#region STATE MACHINE SET UP

stateTimer = 0; // timers for the state machine to use, snowState has built in delta time timers but i don't really like delta time
stateTimerMax = 0;

SM.add("idle", {
    enter: function() {
		(useSkeletonAnimations ? script_setSkeletonAnimation : script_setAnimation)(animIdle, 0, 2.5);
    },
    step: function() {
		if(Health <= 0) {
			die();
		} else {
			movementControls();
			
			if(speed > 1) {
				if((useSkeletonAnimations ? skeletonAnimation : sprite_index) != animRun) {
					(useSkeletonAnimations ? script_setSkeletonAnimation : script_setAnimation)(animRun, 0, 10);
				}
			} else {
				if((useSkeletonAnimations ? skeletonAnimation : sprite_index) != animIdle) {
					(useSkeletonAnimations ? script_setSkeletonAnimation : script_setAnimation)(animIdle, 0, 2.5);
				}
			}
			
			if(InputCheck(INPUT_VERB.JUMP)) {
				if(InputCheck(INPUT_VERB.MAGIC)) {
					SM.change("jumpMagic");
				} else {
					SM.change("jump");
				}
			} else {
				weaponControls();
			}
		}
    },
	leave: function() {
		
	},
});

SM.add("die", {
    enter: function(duration = 120) {
		//die animation
		script_setEventTimer(duration);
		(useSkeletonAnimations ? script_setSkeletonAnimation : script_setAnimation)(animIdle, 0, 0);
		image_angle = 180 + 90 * directionFacing;
    },
    step: function() {
		stateTimer--;
		if(stateTimer <= 0) {
			audio_play_sound(deathSound, 0, 0);
			script_disintegrateObject(,, sprite_width / 4, sprite_height / 4);
			SM.change("idle");
		}
    },
	leave: function() {
		//die animation
		image_angle = 0;
		Health = HealthMax;
		poise = poiseMax;
    },
});

SM.add("jump", {
    enter: function() {
		//jump animation
		(useSkeletonAnimations ? script_setSkeletonAnimation : script_setAnimation)(animJumpStart, 0, 1, 5, true);
		script_setEventTimer(5);
    },
    step: function() {
		if(stateTimer > 0) {
			stateTimer--;
			if(stateTimer <= 0) {
				heightChange = jumpSpeed;
				poise *= .4;
				SM.change("float");
			}
		}
    },
	leave: function() {
		
	},
});

SM.add("jumpMagic", {
    enter: function() {
		(useSkeletonAnimations ? script_setSkeletonAnimation : script_setAnimation)(animJumpStart, 0, 1, 5, true);
		script_setEventTimer(10);
    },
    step: function() {
		if(stateTimer > 0) {
			stateTimer--;
			if(stateTimer <= 0) {
				heightChange = jumpSpeed * 1.5;
				poise *= .4;
					
				trailPart = global.partTrailChunk;
				trailDuration = 55;
				trailPartColor = #cfdfff;
				
				audio_play_sound(snd_iceSpellImpact, 0, 0);
				script_AOEDamageHit(,,, 200, 10, 5,, 5, 200,,, jumpMagicHitFunc);
				OWP_createPartExtColor(global.partThickHaze, x, y, 5, #bbffff,, 70, 0, 1);
				part_type_speed(global.partStar, 2, 5, -.125, 0);
				OWP_createPartExtColor(global.partStar, x, y, 20, #ccffff,, 20, 20, 5);
				part_type_speed(global.partOverwrittenTrailer, 3, 5, 0, 0);
				OWP_createPartExt(global.partOverwrittenTrailer, x, y, 12,, 0, 10, 1);
				
				//create magicJump
				
				SM.change("float");
			}
		}
    },
	leave: function() {
		
	},
});

SM.add("float", {
    enter: function() {
		(useSkeletonAnimations ? script_setSkeletonAnimation : script_setAnimation)(animRise, 0, 3);
    },
    step: function() {
		var _heightChangePrev = heightChange;
		height += heightChange;
		heightChange -= grav;
		
		if(_heightChangePrev > 0 && heightChange <= 0) {
			(useSkeletonAnimations ? script_setSkeletonAnimation : script_setAnimation)(animFall, 0, 3);
		}
		
		movementControls();
		weaponControls();
		
		if(height <= 0) {
			SM.change("idle");
		}
    },
	leave: function() {
		
	},
});

SM.add("melee", {
	enter: function(duration = undefined, type = "basic") {
		var _anim = animHit;
		if(type == "basic") {
			duration = 14;
			meleeAttackType = obj_attackMeleeSwing;
			//_anim = basic;
		} else if(type == "magic") {
			duration = 14;
			meleeAttackType = obj_attackMeleeSwing;
			//_anim = magicMelee; ?
		} else if(type == "burst") {
			duration = 14;
			meleeAttackType = obj_attackMeleeSwing;
			//_anim = magicMelee; ?
		}
		
		script_setEventTimer(duration);
		
		(useSkeletonAnimations ? script_setSkeletonAnimation : script_setAnimation)(_anim, 0, 1, duration, true);
		
		directionFacing = x > mouse_x ? -1 : 1;
    },
    step: function() {
		stateTimer--;
		if(stateTimer <= 0) {
			if(height > 0) {
				SM.change("float");
			} else {
				SM.change("idle");
			}
		} else if(stateTimer == round(stateTimerMax * .5)) {
			var _mouseDir = point_direction(x, y, mouse_x, mouse_y);
			script_createMeleeAttack(meleeAttackType, x + lengthdir_x(20, _mouseDir), y + lengthdir_y(20, _mouseDir), _mouseDir, height,,,, irandom_range(meleeDamage * .8, meleeDamage * 1.2), knockback, knockbackHeight, stun, meleeHitFunc);
		}
    },
	leave: function() {
		
	}
});

SM.add("magicBasic", {
	enter: function(durationMult = 1) {
		var _duration = 36 * durationMult;
		
		script_setEventTimer(_duration);
		
		(useSkeletonAnimations ? script_setSkeletonAnimation : script_setAnimation)(animHit, 0, 1, _duration, true);
		
		directionFacing = x > mouse_x ? -1 : 1;
    },
    step: function() {
		stateTimer--;
		if(stateTimer <= 0) {
			if(height > 0) {
				SM.change("float");
			} else {
				SM.change("idle");
			}
		} else if(stateTimer == round(stateTimerMax * .5)) {
			var _mouseDir = point_direction(x, y, mouse_x, mouse_y);
			script_createAttack(magicBasic, x + lengthdir_x(attackCreateDist, _mouseDir), y + lengthdir_y(attackCreateDist, _mouseDir), _mouseDir + recoil, height,,,,, irandom_range(magicDamage * .8, magicDamage * 1.2)); // recoil..?
		}
    },
	leave: function() {
		
	}
});

SM.add("magicShot", {
	enter: function(durationMult = 1) {
		var _duration = 32 * durationMult;
		
		script_setEventTimer(_duration);
		
		(useSkeletonAnimations ? script_setSkeletonAnimation : script_setAnimation)(animHit, 0, 1, _duration, true);
		
		directionFacing = x > mouse_x ? -1 : 1;
    },
    step: function() {
		stateTimer--;
		if(stateTimer <= 0) {
			if(height > 0) {
				SM.change("float");
			} else {
				SM.change("idle");
			}
		} else if(stateTimer == round(stateTimerMax * .5)) {
			var _mouseDir = point_direction(x, y, mouse_x, mouse_y);
			script_createAttack(magicShot, x + lengthdir_x(attackCreateDist, _mouseDir), y + lengthdir_y(attackCreateDist, _mouseDir), _mouseDir + recoil, height,,,,, irandom_range(magicDamage * .8, magicDamage * 1.2)); // recoil..?
		}
    },
	leave: function() {
		
	}
});

SM.add("magicBurst", {
	enter: function(durationMult = 1) {
		var _duration = 32 * durationMult;
		
		script_setEventTimer(_duration);
		
		(useSkeletonAnimations ? script_setSkeletonAnimation : script_setAnimation)(animHit, 0, 1, _duration, true);
		
		directionFacing = x > mouse_x ? -1 : 1;
    },
    step: function() {
		stateTimer--;
		if(stateTimer <= 0) {
			if(height > 0) {
				SM.change("float");
			} else {
				SM.change("idle");
			}
		} else if(stateTimer == round(stateTimerMax * .5)) {
			var _mouseDir = point_direction(x, y, mouse_x, mouse_y);
			repeat(irandom_range(3, 5)) {
				script_createAttack(magicBurst, x + lengthdir_x(attackCreateDist, _mouseDir), y + lengthdir_y(attackCreateDist, _mouseDir), _mouseDir + recoil + random_range(-11, 11), height, random_range(.7, 1.1),,,, random_range(magicDamage * .8, magicDamage * 1.2)); // recoil..?
			}
		}
    },
	leave: function() {
		
	}
});

SM.add("magicRadial", {
	enter: function(durationMult = 1) {
		var _duration = 35 * durationMult;
		
		script_setEventTimer(_duration);
		
		(useSkeletonAnimations ? script_setSkeletonAnimation : script_setAnimation)(animJumpStart, 0, 1, _duration, true);
		
		directionFacing = x > mouse_x ? -1 : 1;
    },
    step: function() {
		stateTimer--;
		if(stateTimer <= 0) {
			if(height > 0) {
				SM.change("float");
			} else {
				SM.change("idle");
			}
		} else if(stateTimer == round(stateTimerMax * .5)) {
			script_createAttackRadiant(magicRadial, x, y, 0,, 7, 32, 180, .66, c_white,,, random_range(magicDamage * .8, magicDamage * 1.25));
		}
    },
	leave: function() {
		
	}
});

SM.add("magicCall", {
	enter: function(durationMult = 1) {
		var _duration = 60 * durationMult;
		
		script_setEventTimer(_duration);
		
		(useSkeletonAnimations ? script_setSkeletonAnimation : script_setAnimation)(animHit, 0, 1, _duration, true);
		
		directionFacing = x > mouse_x ? -1 : 1;
    },
    step: function() {
		stateTimer--;
		if(stateTimer <= 0) {
			if(height > 0) {
				SM.change("float");
			} else {
				SM.change("idle");
			}
		} else if(stateTimer == round(stateTimerMax * .5)) {
			var _mouseDir = point_direction(x, y, mouse_x, mouse_y);
			script_createAttack(magicCall, x + lengthdir_x(attackCreateDist, _mouseDir), y + lengthdir_y(attackCreateDist, _mouseDir), _mouseDir,,,,,, irandom_range(magicDamage * .8, magicDamage * 1.2)); // recoil..?
		}
    },
	leave: function() {
		
	}
});

SM.add("magicSummon", {
	enter: function(durationMult = 1) {
		var _duration = 80 * durationMult;
		
		script_setEventTimer(_duration);
		
		(useSkeletonAnimations ? script_setSkeletonAnimation : script_setAnimation)(animJumpStart, 0, 1, _duration, true);
		
		directionFacing = x > mouse_x ? -1 : 1;
    },
    step: function() {
		stateTimer--;
		if(stateTimer <= 0) {
			if(height > 0) {
				SM.change("float");
			} else {
				SM.change("idle");
			}
		} else if(stateTimer == round(stateTimerMax * .5)) {
			var _mouseDir = point_direction(x, y, mouse_x, mouse_y);
			script_spawnCreature(magicSummon, 1, x + lengthdir_x(attackCreateDist, _mouseDir), y + lengthdir_y(attackCreateDist, _mouseDir)); // recoil..?
		}
    },
	leave: function() {
		
	}
});



refreshCondition = function() {
	Health = HealthMax;
	poise = poiseMax;
	//..?
}

spawn = function() {
	//stuff to do on creation (after create event and all, last step)
}

movementControls = function() {
	directionAiming = point_direction(x, y, mouse_x, mouse_y);
	
	var _speed = height > 0 ? moveSpeedAir : moveSpeed;
	if(keyboard_check(vk_alt)) {
		_speed *= 9;
	}
	
	if(InputCheck(INPUT_VERB.RIGHT)) {
		hspeed += _speed;
		directionFacing = 1;
	}
	if(InputCheck(INPUT_VERB.LEFT)) {
		hspeed -= _speed;
		directionFacing = -1;
	}
	if(InputCheck(INPUT_VERB.UP)) {
		vspeed -= _speed;
	}
	if(InputCheck(INPUT_VERB.DOWN)) {
		vspeed += _speed;
	}
}

baseTakeDamageFunc = takeDamage;

/// @desc RETURNS LETHAL
/// @param {real} damage 
/// @param {real} direction 
/// @param {real} force 
/// @param {real} heightForce 
/// @returns {bool} LETHAL
takeDamage = function(damage, direction, force, heightForce) {
	//more stuff (inheriting)
	
	baseTakeDamageFunc(damage, direction, force, heightForce);
	
	// more stuff (inheriting)
}

die = function() {
	SM.change("die");
}

meleeHitFunc = function(targetId, sourceId) {
	if(irandom(10) == 0) {
		targetId.image_blend = #ffb8b8;
		targetId.allegiance = sourceId.allegiance;
		
	}
	//targetId.image_blend = randomColor(0, 255, 0);
}

jumpMagicHitFunc = function(damageAOEDropOff, targetId) {
	if(.5 + random(.5) < damageAOEDropOff) {
		targetId.SM.change("frozen");
	}
}

weaponControls = function() {
	if(InputCheck(INPUT_VERB.RIGHTCLICK)) {
		if(InputCheck(INPUT_VERB.MAGIC)) {
			SM.change("magicShot");
		} else if(InputCheck(INPUT_VERB.BURST)) {
			SM.change("magicBurst");
		} else {
			SM.change("magicBasic");
		}
	} else if(InputCheck(INPUT_VERB.LEFTCLICK)) {
		if(InputCheck(INPUT_VERB.MAGIC)) {
			SM.change("melee",,, "magic");
		} else if(InputCheck(INPUT_VERB.BURST)) {
			SM.change("melee",,, "burst");
		} else {
			SM.change("melee",,, "basic");
		}
		//instance_create_depth(mouse_x, mouse_y, depth, obj_smiteBeam);
	} else if(InputCheck(INPUT_VERB.SPECIAL)) { // C
		if(InputCheck(INPUT_VERB.MAGIC)) {
			SM.change("magicCall");
		} else if(InputCheck(INPUT_VERB.BURST)) {
			SM.change("magicRadial"); // ??
		} else {
			SM.change("magicSummon");
		}
	}
}

postCreate();