event_inherited();

allegiance = E_allegiance.knight;

HealthMax = 65;
poiseMax = 500;

attackRange = 150;

damage = 5;
meleeDamage = 10;
knockback = 4;

attackRange = 50;
attackRangeRangedMax = 180;
attackRangeRangedMin = 110;

#region animation
useSkeletonAnimations = true;

	skeletonBasicItem = choose(spr_swordBlackPoker, spr_swordFantasy);//choose(spr_swordFantasy, spr_swordBranch, spr_swordBlackPoker, spr_swordIce);
	skeletonBasicHandRightSprite = spr_flameMonsterHandRight;
	skeletonBasicHandLeftSprite = spr_flameMonsterHandRight;
	skeletonBasicHeadSprite = spr_monkHead;
	skeletonBasicBodySprite = spr_monkBodyIdle;

	skeletonData = [
			[ [ [skeletonBasicItem, 0], [skeletonBasicHandRightSprite, 0], [skeletonBasicHandLeftSprite, 0], [skeletonBasicHeadSprite, 0], [spr_monkBodyIdle, 0], [spr_flameMonsterLegsIdle, 0] ],
			  [ [skeletonBasicItem, 0], [skeletonBasicHandRightSprite, 0], [skeletonBasicHandLeftSprite, 0], [skeletonBasicHeadSprite, 0], [spr_monkBodyIdle, 1], [spr_flameMonsterLegsIdle, 1] ], ],
			[ [ [skeletonBasicItem, 0], [skeletonBasicHandRightSprite, 0], [skeletonBasicHandLeftSprite, 0], [skeletonBasicHeadSprite, 0], [spr_monkBodyRun, 0], [spr_flameMonsterLegsRun, 0] ],
			  [ [skeletonBasicItem, 0], [skeletonBasicHandRightSprite, 0], [skeletonBasicHandLeftSprite, 0], [skeletonBasicHeadSprite, 0], [spr_monkBodyRun, 1], [spr_flameMonsterLegsRun, 1] ],
			  [ [skeletonBasicItem, 0], [skeletonBasicHandRightSprite, 0], [skeletonBasicHandLeftSprite, 0], [skeletonBasicHeadSprite, 0], [spr_monkBodyRun, 2], [spr_flameMonsterLegsRun, 2] ],
			  [ [skeletonBasicItem, 0], [skeletonBasicHandRightSprite, 0], [skeletonBasicHandLeftSprite, 0], [skeletonBasicHeadSprite, 0], [spr_monkBodyRun, 3], [spr_flameMonsterLegsRun, 3] ], ],
			[ [ [-1, 0], [-1, 0], [skeletonBasicHandLeftSprite, 0], [skeletonBasicHeadSprite, 0], [spr_monkBodyHit, 0], [spr_flameMonsterLegsHit, 0] ],
			  [ [-1, 0], [-1, 0], [skeletonBasicHandLeftSprite, 0], [skeletonBasicHeadSprite, 0], [spr_monkBodyHit, 1], [spr_flameMonsterLegsHit, 1] ],
			  [ [-1, 0], [-1, 0], [skeletonBasicHandLeftSprite, 0], [skeletonBasicHeadSprite, 0], [spr_monkBodyHit, 2], [spr_flameMonsterLegsHit, 2] ],
			  [ [-1, 0], [-1, 0], [skeletonBasicHandLeftSprite, 0], [skeletonBasicHeadSprite, 0], [spr_monkBodyHit, 3], [spr_flameMonsterLegsHit, 3] ],
			  [ [-1, 0], [-1, 0], [skeletonBasicHandLeftSprite, 0], [skeletonBasicHeadSprite, 0], [spr_monkBodyHit, 4], [spr_flameMonsterLegsHit, 4] ], ],
			[ [ [skeletonBasicItem, 0], [skeletonBasicHandRightSprite, 0], [skeletonBasicHandLeftSprite, 0], [skeletonBasicHeadSprite, 0], [spr_monkBodyJumpStart, 0], [spr_flameMonsterLegsJumpStart, 0] ],
			  [ [skeletonBasicItem, 0], [skeletonBasicHandRightSprite, 0], [skeletonBasicHandLeftSprite, 0], [skeletonBasicHeadSprite, 0], [spr_monkBodyJumpStart, 1], [spr_flameMonsterLegsJumpStart, 1] ],
			  [ [skeletonBasicItem, 0], [skeletonBasicHandRightSprite, 0], [skeletonBasicHandLeftSprite, 0], [skeletonBasicHeadSprite, 0], [spr_monkBodyJumpStart, 2], [spr_flameMonsterLegsJumpStart, 2] ],
			  [ [skeletonBasicItem, 0], [skeletonBasicHandRightSprite, 0], [skeletonBasicHandLeftSprite, 0], [skeletonBasicHeadSprite, 0], [spr_monkBodyJumpStart, 3], [spr_flameMonsterLegsJumpStart, 3] ], ],
			[ [ [skeletonBasicItem, 0], [skeletonBasicHandRightSprite, 0], [skeletonBasicHandLeftSprite, 0], [skeletonBasicHeadSprite, 0], [spr_monkBodyJumpRise, 0], [spr_flameMonsterLegsJumpRise, 0] ],
			  [ [skeletonBasicItem, 0], [skeletonBasicHandRightSprite, 0], [skeletonBasicHandLeftSprite, 0], [skeletonBasicHeadSprite, 0], [spr_monkBodyJumpRise, 1], [spr_flameMonsterLegsJumpRise, 1] ], ],
			[ [ [skeletonBasicItem, 0], [skeletonBasicHandRightSprite, 0], [skeletonBasicHandLeftSprite, 0], [skeletonBasicHeadSprite, 0], [spr_monkBodyJumpFall, 0], [spr_flameMonsterLegsJumpFall, 0] ],
			  [ [skeletonBasicItem, 0], [skeletonBasicHandRightSprite, 0], [skeletonBasicHandLeftSprite, 0], [skeletonBasicHeadSprite, 0], [spr_monkBodyJumpFall, 1], [spr_flameMonsterLegsJumpFall, 1] ], ],
	]

//image_blend = #ff1a1a;
image_blend = #ffffff;

#endregion

SM.add("attackRanged", {
    enter: function(duration = 30) {
		//die animation
		script_setEventTimer(duration);
		image_angle = 20;
    },
    step: function() {
		stateTimer--;
		if(stateTimer <= 0) {
			SM.change("chase");
		} else if(abs(stateTimer - round(stateTimerMax * .5)) == 0) {
			var _radiant = script_createAttackRadiant(obj_radiantAttack, x, y, 0,, 20, 32, 100, .7, #ccccff);
			//var _aimDir = irandom(360);
			//for(var _i = 0; _i < 18; _i++) {
				//_aimDir += 20;
				//script_createAttack(obj_bullet, x + lengthdir_x(16, _aimDir), y + lengthdir_y(16, _aimDir), _aimDir, height, .8, 2,,, damage, knockback,, 5);
			//}
		}
    },
	leave: function() {
		image_angle = 0;
	}
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

//SM.add_child("chase", "chaseKill", {
	//enter: function() {
    	//SM.inherit();
	//},
	//step: function() {
		//SM.inherit();
		//if(irandom(10) == 0) {
			//script_AOEDamageHit(,,, 100, 1, 5,, 2, 20);
		//}
	//}
//});