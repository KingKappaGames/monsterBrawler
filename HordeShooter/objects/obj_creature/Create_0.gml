HealthMax = 25;
Health = HealthMax;

meleeDamage = 5;
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
speedDecay = .8;
speedDecayAir = .98;

heightChange = 0;
height = 0;
bounceHorizontalSpeedtMult = .8;
bounceHeightMult = -.4;

moveSpeed = .52;
moveSpeedAir = .4;
jumpSpeed = 6;
knockbackMult = 1;
knockbackMultBase = 1;

npcAroundList = ds_list_create();
npcAroundCount = 0;

canMove = true;
intangible = false; // cannot be hit or affected by effects (different than i frames i think?)

hitFlash = 0;

directionFacing = choose(-1, 1);

poiseMax = 80;
poise = poiseMax;

allegiance = choose(E_allegiance.barbarian, E_allegiance.knight);

agroId = noone;
agroRange = 900;

deathSound = snd_crunch;

burning = 0;
acidic = 0;
frozen = 0; // state

alwaysBurning = false;

trailPart = -1;
trailDuration = 0;
trailPartColor = c_white;

#region animations
	useSkeletonAnimations = false;
	
	skeletonAnimation = E_animation.idle;
	
	animIdle = E_animation.idle;
	animRun = E_animation.run;
	animHit = E_animation.hit;
	animJumpStart = E_animation.jumpBegin; // So... this is the default value of these common good variables, the way I see it is that all creatures will override these values IF they are actual animation creatures, if not then they keep the default skeleton animation values... Maybe this is stupid, fix if stupid
	animRise = E_animation.rise;
	animFall = E_animation.fall;
	
	bodySurf = -1;
	
	getBodySurf = function() {
		if(!surface_exists(bodySurf)) {
			bodySurf = surface_create(128, 128); // is 128 always the size?
		}
		
		return bodySurf;
	}
	 
	skeletonBasicItem = choose(spr_swordFantasy, spr_swordBranch, spr_swordBlackPoker, spr_swordIce);
	skeletonBasicHandRightSprite = spr_flameMonsterHandRight;
	skeletonBasicHandLeftSprite = spr_flameMonsterHandRight;
	skeletonBasicHeadSprite = spr_flameMonsterHead;
	skeletonBasicBodySprite = spr_flameMonsterBody;

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
	
	//perhaps create set of x/y for just the 4 body parts to set to that they can be lerped or accelerated towards goals (and away from forces like attacks) but eh
#endregion

#region STATE MACHINE SET UP

stateTimer = 0; // timers for the state machine to use, snowState has built in delta time timers but i don't really like delta time
stateTimerMax = 0;

SM = new SnowState("idle");

SM.add("idle", {
    enter: function() {
		(useSkeletonAnimations ? script_setSkeletonAnimation : script_setAnimation)(animIdle, 0, 2.5);
    },
    step: function() {
		if(speed > 1) {
			if((useSkeletonAnimations ? skeletonAnimation : sprite_index) != animRun) {
				(useSkeletonAnimations ? script_setSkeletonAnimation : script_setAnimation)(animRun, 0, 10);
			}
		} else {
			if((useSkeletonAnimations ? skeletonAnimation : sprite_index) != animIdle) {
				(useSkeletonAnimations ? script_setSkeletonAnimation : script_setAnimation)(animIdle, 0, 2.5);
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
		(useSkeletonAnimations ? script_setSkeletonAnimation : script_setAnimation)(animRun, 0, 10);
    },
    step: function() {
		if(Health <= 0) {
			die();
		} else {
			if(instance_exists(agroId)) {
				if(agroId.Health <= 0) {
					agroId = noone;
				} else {
					
					var _dirMove = point_direction(x, y, agroId.x, agroId.y) + dsin(current_time * .041) * 30 + dsin(current_time * .067) * 21 - dsin(current_time * .137) * 18;
					motion_add(_dirMove, moveSpeed);
					
					#region steering behavior movement
					if(irandom(6) == 0) {
						ds_list_clear(npcAroundList)
						npcAroundCount = collision_circle_list(x, y, 500, obj_creature, false, true, npcAroundList, true); // get nearby npcs
						var _avoidedNpcCount = 0;
							
						#region avoiding stuff (janky?)
						var _avoiding = true; // as you go up check the avoid vs approach difference to see if you should check for this
					
						
						if(npcAroundCount > 0) {
							var _approachX = 0;
							var _approachY = 0;
						
							var _initialSpeedX = hspeed;
							var _initialSpeedY = vspeed; // hold and clear speed to allow use of built in speed adding functions (this structure doesn't make much sense but let's you use the way faster motion scripts in a place where performance is an issue so.. For the best)
							speed = 0;
							
							var _avoidDir = 0;
							var _avoidDist = 0;
							
							var _enemy, _enemyX, _enemyY;
							#endregion
							
							for(var _i = 0; _i < npcAroundCount; _i++) {
								_enemy = npcAroundList[| _i];
								_enemyX = _enemy.x;
								_enemyY = _enemy.y;
								
								_approachX += _enemyX;
								_approachY += _enemyY;
								
								if(_avoiding) {
									_avoidDist = point_distance(_enemyX, _enemyY, x, y);
									if(_avoidDist < 75) {
										_avoidDir = point_direction(_enemyX, _enemyY, x, y);
										
										motion_add(_avoidDir, 45 / max(power(_avoidDist, .75), 1.75));
									} else {
										_avoidedNpcCount = _i;
										_avoiding = false;
									}
								}
							}
					
							_approachX /= npcAroundCount;
							_approachY /= npcAroundCount;
							
							if(_avoidedNpcCount > 0) {
								speed = min(speed / _avoidedNpcCount, .7);
							}
							
							var _approachDir = point_direction(x, y, _approachX, _approachY);
							var _approachDist = point_distance(x, y, _approachX, _approachY); // move towars center of mass
							motion_add(_approachDir, _approachDist / 20_000);
							
							hspeed += _initialSpeedX;
							vspeed += _initialSpeedY;
						}
					}
					#endregion
					
					if(_dirMove > 90 && _dirMove < 270) {
						directionFacing = -1;
					} else {
						directionFacing = 1;
					}
					
					if(irandom(600) == 0) {
						SM.change("jump");
					} else {
						if(irandom(45) == 0) {
							agroId = script_findAgroTarget();
						} else {
							determineAttack(); // sets state if done
						}
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
			
			
			(useSkeletonAnimations ? script_setSkeletonAnimation : script_setAnimation)(animHit, 0, 1, 14, true);
			
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
				script_createMeleeAttack(meleeAttackType, x + lengthdir_x(20, _attackDir), y + lengthdir_y(20, _attackDir), _attackDir, height,,,, irandom_range(meleeDamage * .8, meleeDamage * 1.2));
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
				script_createMeleeAttack(obj_attackMeleeSwing, x + lengthdir_x(20, _attackDir), y + lengthdir_y(20, _attackDir), _attackDir, height,,,, irandom_range(4, 6));
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
			if(instance_exists(agroId)) {
				var _attackDir = directionTo(agroId);
				script_createAttack(obj_acidBolt, x + lengthdir_x(attackCreateDist, _attackDir), y + lengthdir_y(attackCreateDist, _attackDir), _attackDir, height);
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
		(useSkeletonAnimations ? script_setSkeletonAnimation : script_setAnimation)(animIdle, 0, 0);
		image_angle = 180 + 90 * directionFacing;
    },
    step: function() {
		stateTimer--;
		if(stateTimer <= 0) {
			audio_play_sound(deathSound, 0, 0);
			script_disintegrateObject(,, sprite_width / 4, sprite_height / 4);
			if(irandom(10) == 0) {
				script_createPickup(x, y + 5, obj_pickup);
			}
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
			if(heightChange < -.7) {
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

#endregion

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
	Health = min(HealthMax, Health - damage);
	
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

#region magic functions
jumpMagicHitFunc = function(damageAOEDropOff, targetId) {
	if(.5 + random(.5) < damageAOEDropOff) {
		targetId.SM.change("frozen");
	}
}

doJumpMagic = function() {
	trailPart = global.partTrailChunk;
	trailDuration = 45;
	trailPartColor = #cfdfff;
	
	audio_play_sound(snd_iceSpellImpact, 0, 0);
	script_AOEDamageHit(,,, 200, 10, 5,, 5, 200,,, jumpMagicHitFunc);
	OWP_createPartExtColor(global.partThickHaze, x, y, 5, #bbffff,, 70, 0, 1);
	part_type_speed(global.partStar, 2, 5, -.125, 0);
	OWP_createPartExtColor(global.partStar, x, y, 20, #ccffff,, 20, 20, 5);
	part_type_speed(global.partOverwrittenTrailer, 3, 5, 0, 0);
	OWP_createPartExt(global.partOverwrittenTrailer, x, y, 12,, 0, 10, 1);
}
#endregion