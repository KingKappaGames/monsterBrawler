event_inherited();

HealthMax = 10000000000000;
Health = HealthMax;

hspeed = 0;
vspeed = 0;
speedDecay = .78;
speedDecayAir = .92;

heightChange = 0;
height = 0;
bounceHorizontalSpeedtMult = .8;
bounceHeightMult = -.4;

moveSpeed = 2.50;
moveSpeedAir = 1.1;

jumpSpeed = 5.4;
knockbackMult = 1;

canMove = true;
intangible = false; // cannot be hit or affected by effects (different than i frames i think?)

directionFacing = choose(-1, 1);

poiseMax = 80;
poise = poiseMax;

allegiance = E_allegiance.player;
sprite_index = spr_rager;

deathSound = snd_crunch;

#region goofy values

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

cameraOne = camera_create_view(0, 0, 1920, 1080);
view_set_camera(0, cameraOne); //view_camera[0] or [1] worked

view_enabled = 1;
view_visible[0] = true;

view_wport[0] = 1920;
view_hport[0] = 1080;

global.cam = view_camera[0];

#endregion

#region STATE MACHINE SET UP

stateTimer = 0; // timers for the state machine to use, snowState has built in delta time timers but i don't really like delta time
stateTimerMax = 0;

SM.add("idle", {
    enter: function() {
		
    },
    step: function() {
		movementControls();
		
		if(InputCheck(INPUT_VERB.JUMP)) {
			SM.change("jump");
		}
		
		if(mouse_check_button(mb_left)) {
			shotDelay--;
			if(shotDelay <= 0) {
				shotDelay = 60 / fireRate;
				shootBullet();
			}
		} else if(mouse_check_button_released(mb_left)) {
			shotDelay = 60 / fireRate;
		}
		
		if(mouse_check_button_released(mb_right)) {
			instance_create_depth(mouse_x, mouse_y, depth, obj_smiteBeam);
		}
		
		if(keyboard_check_released(ord("G"))) {
			repeat(1 + irandom(2)) {
				script_createAttack(obj_grenade, x, y, directionAiming + irandom_range(-40, 40), random_range(1, 1.2), 5);
			}
		}
		
		if(keyboard_check_pressed(ord("M"))) {
			mortaring = 1;
			mortarXstart = mouse_x;
			mortarYstart = mouse_y;
		}
		
		if(keyboard_check_pressed(vk_alt)) {
			script_spawnCreature(choose(obj_barbarian, obj_knight), 1 + irandom(10), mouse_x, mouse_y);
		}
		
		if(keyboard_check_released(ord("M"))) {
			var _plane = instance_create_depth(0, 0, 0, obj_plane);
			_plane.startRunX = mortarXstart;
			_plane.startRunY = mortarYstart;
			_plane.endRunX = mouse_x;
			_plane.endRunY = mouse_y;
			_plane.getRoute();
			mortaring = 0;
		}
		
		spread *= spreadDecay;
		recoil *= 1 - (1 - spreadDecay) * 5;
		if(spread < spreadMinimum) {
			spread = spreadMinimum;
		}
    },
	leave: function() {
		
	},
});

SM.add("die", {
    enter: function(duration = 120) {
		//die animation
		script_setEventTimer(duration);
    },
    step: function() {
		stateTimer--;
		if(stateTimer <= 0) {
			audio_play_sound(deathSound, 0, 0);
			script_disintegrateObject(,, sprite_width / 4, sprite_height / 4);
			SM.change("idle");
		}
    },
});

SM.add("jump", {
    enter: function() {
		//jump animation
		heightChange = jumpSpeed;
		poise *= .75;
    },
    step: function() {
		height += heightChange;
		heightChange -= grav;
		movementControls();
		if(height <= 0) {
			SM.change("idle");
		}
    },
	leave: function() {
		
	},
});

SM.add("knockdown", {
    enter: function(duration = 30) {
		//animation set to knockdown image
		script_setEventTimer(duration);
		image_angle = 90;
    },
    step: function() {
		height += heightChange;
		heightChange -= grav;
		if(height <= 0) {
			if(heightChange < -.5) {
				hspeed *= bounceHorizontalSpeedtMult;
				vspeed *= bounceHorizontalSpeedtMult;
				heightChange *= bounceHeightMult;
				height = 0;
			} else {
				hspeed *= bounceHorizontalSpeedtMult;
				vspeed *= bounceHorizontalSpeedtMult;
				heightChange = 0;
				height = 0;
				stateTimer--;
				if(stateTimer <= 0) {
					SM.change("idle");
				}
			}
		}
    },
	leave: function() {
		image_angle = 0;
		poise = poiseMax;
	},
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
		_bulletType = obj_iceBolt;
		_spawnArea = 0;
	}
	
	var _shot = script_createAttack(_bulletType, x + dcos(directionAiming) * 16 + irandom_range(-_spawnArea, _spawnArea), y - dsin(directionAiming) * 16 + irandom_range(-_spawnArea, _spawnArea), directionAiming + random_range(-spread, spread), shotSpeed,,,, damage);

	spread += 1;
	recoil += 2;
}

movementControls = function() {
	directionAiming = point_direction(x, y, mouse_x, mouse_y);
	
	var _speed = height > 0 ? moveSpeedAir : moveSpeed;
	
	if(InputCheck(INPUT_VERB.RIGHT)) {
		hspeed += _speed;
	}
	if(InputCheck(INPUT_VERB.LEFT)) {
		hspeed -= _speed;
	}
	if(InputCheck(INPUT_VERB.UP)) {
		vspeed -= _speed;
	}
	if(InputCheck(INPUT_VERB.DOWN)) {
		vspeed += _speed;
	}
}

/// @desc RETURNS LETHAL
/// @param {real} damage 
/// @param {real} direction 
/// @param {real} force 
/// @param {real} heightForce 
/// @returns {bool} LETHAL
takeDamage = function(damage, direction, force, heightForce) {
	Health -= damage;
	
	poise -= power(damage + force, 1);
	
	if(poise <= 0) {
		if(SM.get_current_state() != "die") {
			SM.change("knockdown");
		}
		
		hspeed += lengthdir_x(force * 1.5 * knockbackMult, direction);
		vspeed += lengthdir_y(force * 1.5 * knockbackMult, direction);
		heightChange += heightForce;
	} else {
		hspeed += lengthdir_x(force * knockbackMult, direction);
		vspeed += lengthdir_y(force * knockbackMult, direction);
	}
	
	if(Health <= 0) {
		if(SM.get_current_state() != "die") {
			die();
			
			return true;
		}
	}
	
	return false;
}

die = function() {
	SM.change("die");
}