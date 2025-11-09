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

moveSpeed = 1.55;
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
#endregion

deathSound = snd_crunch;

var sec = game_get_speed(gamespeed_fps)

weaponType = 1; //1 machine gun, 2 rockets, 3 ???

fireRate = 20;
shotDelay = 0;
damage = 1;
shotSpeed = 1;

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

view_wport[0] = 1920;
view_hport[0] = 1080;

surface_resize(application_surface, 1920, 1080);
window_set_size(1920, 1080);

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
				SM.change("jump");
			}
			
			weaponControls();
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
				if(keyboard_check(vk_shift)) {
					heightChange = jumpSpeed * 1.5;
					poise *= .4;
					
					doJumpMagic();
				} else {
					heightChange = jumpSpeed;
					poise *= .4;
				}
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
	enter: function(duration = undefined, type = obj_attackMeleeSwing) {
		meleeAttackType = type;
		if(type == obj_attackMeleeSwing) {
			duration = 14;
		} else {
			duration = 14;
		}
		
		script_setEventTimer(duration);
		
		(useSkeletonAnimations ? script_setSkeletonAnimation : script_setAnimation)(animHit, 0, 1, 14, true);
		
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
			script_createMeleeAttack(meleeAttackType, x + lengthdir_x(20, _mouseDir), y + lengthdir_y(20, _mouseDir), _mouseDir, height,,,, irandom_range(meleeDamage * .8, meleeDamage * 1.2),,,, meleeHitFunc);
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

shootBullet = function() {
	var _bulletType = obj_bullet;
	var _spawnArea = 0;
	if(weaponType == 2) {
		_bulletType = obj_rocket;
		_spawnArea = 50;
	} else if(weaponType == 3) {
		_bulletType = obj_fireJet;
		_spawnArea = 0;
	} else if(weaponType == 4) {
		_bulletType = obj_starBolt;
		_spawnArea = 0;
	}
	
	var _shot = script_createAttack(_bulletType, x + dcos(directionAiming) * 16 + irandom_range(-_spawnArea, _spawnArea), y - dsin(directionAiming) * 16 + irandom_range(-_spawnArea, _spawnArea), directionAiming + random_range(-spread, spread), height, shotSpeed,,,, damage);

	spread += 1;
	recoil += 2;
}

movementControls = function() {
	directionAiming = point_direction(x, y, mouse_x, mouse_y);
	
	var _speed = height > 0 ? moveSpeedAir : moveSpeed;
	
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

doJumpMagic = function() {
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
}

weaponControls = function() {
	if(mouse_check_button(mb_right)) {
		shotDelay--;
		if(shotDelay <= 0) {
			shotDelay = 60 / fireRate;
			shootBullet();
		}
	} else if(mouse_check_button_released(mb_right)) {
		shotDelay = 60 / fireRate;
	}
	
	if(mouse_check_button_released(mb_left)) {
		SM.change("melee",,, "basic");
		//instance_create_depth(mouse_x, mouse_y, depth, obj_smiteBeam);
	}
	
	if(keyboard_check_released(ord("J"))) {
		
	}
	
	if(keyboard_check_pressed(ord("M"))) {
		mortaring = 1;
		mortarXstart = mouse_x;
		mortarYstart = mouse_y;
	} else if(keyboard_check_released(ord("M"))) {
		var _plane = instance_create_depth(0, 0, 0, obj_plane);
		_plane.startRunX = mortarXstart;
		_plane.startRunY = mortarYstart;
		_plane.endRunX = mouse_x;
		_plane.endRunY = mouse_y;
		_plane.getRoute();
		mortaring = 0;
	}
}