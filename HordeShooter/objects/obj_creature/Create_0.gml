HealthMax = 25;
Health = HealthMax;

damage = 1;
knockback = 1;
knockbackHeight = 1;
stun = 10;

attackRange = 50;

hspeed = 0;
vspeed = 0;
speedDecay = .84;
speedDecayAir = .98;

heightChange = 0;
height = 0;
bounceHorizontalSpeedtMult = .8;
bounceHeightMult = -.4;

moveSpeed = .62;
moveSpeedAir = .4;
jumpSpeed = 3;
knockbackMult = 1;

canMove = true;
intangible = false; // cannot be hit or affected by effects (different than i frames i think?)

directionFacing = choose(-1, 1);

poiseMax = 80;
poise = poiseMax;

allegiance = choose(E_allegiance.barbarian, E_allegiance.knight);
if(allegiance == E_allegiance.barbarian) {
	sprite_index = Sprite3;
}

agroId = noone;
agroRange = 1200;

deathSound = snd_crunch;

#region STATE MACHINE SET UP

stateTimer = 0; // timers for the state machine to use, snowState has built in delta time timers but i don't really like delta time
stateTimerMax = 0;

SM = new SnowState("idle");

SM.add("idle", {
    enter: function() {
		
    },
    step: function() {
		if(Health <= 0) {
			die();
		} else {
			if(irandom(10) == 0) {
				agroId = script_findAgroTarget();
				if(instance_exists(agroId)) {
					SM.change("chase");
				}
			}
		}
    },
	leave: function() {
		
	},
});

SM.add("chase", {
    enter: function() {
		
    },
    step: function() {
		if(Health <= 0) {
			die();
		} else {
			if(instance_exists(agroId)) {
				if(agroId.Health <= 0) {
					agroId = noone;
				} else {
					var _dirMove = point_direction(x, y, agroId.x, agroId.y) + dsin(current_time * .031) * 35 + dsin(current_time * .057) * 25 - dsin(current_time * .117) * 20;
					motion_add(_dirMove, moveSpeed);
					
					if(_dirMove > 90 && _dirMove < 270) {
						directionFacing = -1;
					} else {
						directionFacing = 1;
					}
					
					if(point_distance(x, y, agroId.x, agroId.y) < attackRange) {
						SM.change("attack");
					}
					
					if(irandom(45) == 0) {
						agroId = script_findAgroTarget();
					}
				}
			} else {
				agroId = script_findAgroTarget();
				if(!instance_exists(agroId)) {
					SM.change("idle");
				}
			}
		}
    },
	leave: function() {
		
	},
});

SM.add("attack", {
    enter: function(duration = 30) {
		//die animation
		script_setEventTimer(duration);
		image_angle = 20;
    },
    step: function() {
		stateTimer--;
		if(stateTimer <= 0) {
			SM.change("chase");
		} else if(stateTimer == round(stateTimerMax * .5)) {
			var _lethal = agroId.takeDamage(irandom_range(3, 4), point_direction(x, y, agroId.x, agroId.y), random_range(3, 10), random(6));
			if(_lethal) {
				agroId = noone;
			}
		}
    },
	leave: function() {
		image_angle = 0;
	}
});

SM.add("die", {
    enter: function(duration = 60) {
		//die animation
		script_setEventTimer(duration);
		image_angle = 90;
    },
    step: function() {
		stateTimer--;
		if(stateTimer <= 0) {
			audio_play_sound(deathSound, 0, 0);
			script_disintegrateObject(,, sprite_width / 4, sprite_height / 4);
			instance_destroy();
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
				heightChange = min(12, heightChange * bounceHeightMult);
				script_createParticles(x, y, global.partDust, 10, #af8a61);
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


slowdown = function() {
	if(height > 0) {
		hspeed *= speedDecayAir;
		vspeed *= speedDecayAir;	
	} else {
		hspeed *= speedDecay;
		vspeed *= speedDecay;
	}
}

refreshCondition = function() {
	Health = HealthMax;
	poise = poiseMax;
	//..?
}

spawn = function() {
	//stuff to do on creation (after create event and all, last step)
}

/// @desc RETURNS LETHALITY
/// @param {real} damage 
/// @param {real} direction 
/// @param {real} force 
/// @param {real} heightForce 
/// @returns {bool} LETHAL
takeDamage = function(damage, direction, force, heightForce, stun = undefined, makeHitNumber = true) {
	Health -= damage;
	script_createHitNum(damage);
	
	stun ??= power(damage + force, 1);
	poise -= stun;
	
	if(poise <= 0) {
		if(SM.get_current_state() != "die") {
			SM.change("knockdown");
		}
		
		motion_add(direction, force * 1.5 * knockbackMult); // damn there's a motion add function so that even the x/y adding lines can be baked down into one script instead of x/y += x/y force...
		heightChange *= .4; // only add or reset to 0 when hitting enemies out of the air, this lets you dribble more easily (like castle crashers)
		heightChange += heightForce;
	} else {
		motion_add(direction, force * knockbackMult);
	}
	
	if(Health <= 0) {
		return true;
	} else {
		return false;
	}
}

die = function() {
	SM.change("die");
}