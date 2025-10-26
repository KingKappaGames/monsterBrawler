HealthMax = 25;
Health = HealthMax;

damage = 1;
knockback = 1;
knockbackHeight = 1;
stun = 10;

attackRange = 50;
attackRangeRangedMax = 450;
attackRangeRangedMin = 240;
attackCreateDist = 15; // this is the distance from the origin that spells and attacks are placed, aka the maw, aka the reach, aka the start distance of a spell from it's castor

meleeAttackType = obj_attackMeleeSwing;

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
knockbackMultBase = 1;

canMove = true;
intangible = false; // cannot be hit or affected by effects (different than i frames i think?)

hitFlash = 0;

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

burning = 0;
acidic = 0;
frozen = 0; // state

#region STATE MACHINE SET UP

stateTimer = 0; // timers for the state machine to use, snowState has built in delta time timers but i don't really like delta time
stateTimerMax = 0;

SM = new SnowState("idle");

SM.add("idle", {
    enter: function() {
		sprite_index = spr_playerIdle;
		image_index = 0;
		image_speed = 2.5;
    },
    step: function() {
		if(speed > 1) {
			if(sprite_index != spr_playerRun) {
				sprite_index = spr_playerRun;
				image_index = 0;
				image_speed = 10;
			}
		} else {
			if(sprite_index != spr_playerIdle) {
				sprite_index = spr_playerIdle;
				image_index = 0;
				image_speed = 2.5;
			}
		}
		
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
		sprite_index = spr_playerRun;
		image_index = 0;
		image_speed = 10;
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
					
					determineAttack(); // sets state if done
					
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

SM.add("melee", {
	enter: function(duration = undefined, type = obj_attackMeleeSwing) {
		if(instance_exists(agroId)) {
			meleeAttackType = type;
			if(type == obj_attackMeleeSwing) {
				duration = 14;
			} else {
				duration = 14;
			}
			
			script_setEventTimer(duration);
			
			script_setAnimation(spr_playerHit, 0, 1, 14, true);
			
			directionFacing = x > agroId.x ? -1 : 1;
		} else {
			SM.change("idle");
		}
    },
    step: function() {
		stateTimer--;
		if(stateTimer <= 0) {
			SM.change("chase");
		} else if(stateTimer == round(stateTimerMax * .5)) {
			if(instance_exists(agroId)) {
				var _attackDir = point_direction(x, y, agroId.x, agroId.y);
				script_createMeleeAttack(meleeAttackType, x + lengthdir_x(20, _attackDir), y + lengthdir_y(20, _attackDir), _attackDir,,,, irandom_range(4, 6));
			} else {
				SM.change("idle");
			}
		}
    },
	leave: function() {
		
	}
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
			if(point_distance(x, y, agroId.x, agroId.y) < 60) {
				var _attackDir = point_direction(x, y, agroId.x, agroId.y);
				script_createMeleeAttack(obj_attackMeleeSwing, x + lengthdir_x(20, _attackDir), y + lengthdir_y(20, _attackDir), _attackDir,,,, irandom_range(4, 6));
				//var _lethal = agroId.takeDamage(irandom_range(3, 4), point_direction(x, y, agroId.x, agroId.y), random_range(4, 10), random(7));
				
				//if(_lethal) {
					//agroId = noone;
				//}
			}
		}
    },
	leave: function() {
		image_angle = 0;
	}
});

SM.add("attackRanged", {
    enter: function(duration = 40) {
		//die animation
		script_setEventTimer(duration);
		image_angle = 10;
    },
    step: function() {
		stateTimer--;
		if(stateTimer <= 0) {
			SM.change("chase");
		} else if(stateTimer == round(stateTimerMax * .5)) {
			var _attackDir = directionTo(agroId);
			script_createAttack(obj_acidBolt, x + lengthdir_x(attackCreateDist, _attackDir), y + lengthdir_y(attackCreateDist, _attackDir), _attackDir);
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
		sprite_index = spr_playerIdle;
		image_index = 0;
		image_speed = 0;
		image_angle = 180 + 90 * directionFacing;
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
				OWP_createPartExtColor(global.partDust, x, y, 10, #af8a61,, sprite_width * .3, 4);
				audio_play_sound(snd_fallBonk, 0, 0, 1 + sqrt(abs(heightChange)) * .5);
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

SM.add("frozen", {
    enter: function(duration = 270) {
		//frozen animation
		image_speed = 0;
		frozen = duration;
		burning = 0; // no burning while frozen in a block of ice bro
		knockbackMult = 0; // don't move while frozen
		friction = 100;
    },
    step: function() {
		if(irandom(30) == 0) {
			OWP_createPart(global.partThickHaze, x + irandom_range(-sprite_width * .4, sprite_width * .4), y + irandom_range(-sprite_height * .4, sprite_height * .4), 1, #bbffff, -y - 20);
		}
		
		frozen--;
		if(frozen <= 0) {
			SM.change("knockdown");
		}
    },
	leave: function() {
		OWP_createPartExtColor(global.partBreak, x, y, 40, #bbffff,, sprite_width * .4, 20, 4);
		audio_play_sound(snd_iceBreak, 0, 0);
		
		frozen = 0;
		knockbackMult = knockbackMultBase; // don't move while frozen
		friction = 0;
		
		motion_add(irandom(360), random(3));
	},
});

determineAttack = function() {
	var _state = "none";
	var _targetDist = point_distance(x, y, agroId.x, agroId.y);
	if(_targetDist < attackRange) {
		if(irandom(15) == 0) {
			_state = "melee";
		}
	} else if(_targetDist < attackRangeRangedMax && _targetDist > attackRangeRangedMin) {
		if(irandom(500) == 0) {
			_state = "attackRanged";
		}
	}
	
	if(_state != "none") {
		SM.change(_state);
	}
	
	return _state; // state names randomly chosen, in theory they could probably just call the SM.change themselves but idk man
}

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
takeDamage = function(damage, direction, force, heightForce, stun = undefined, makeHitNumber = true, doEffects = true) {
	Health -= damage;
	
	script_createHitNum(damage);
	
	if(doEffects) {
		hitFlash = max(hitFlash, 7);
		
		part_type_speed(global.partStarMini, 3.5, 5.5, -.15, 0);
		OWP_createPartExt(global.partStarMini, x, y, 2 + damage,, 10, 10, 1);
	}
	
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