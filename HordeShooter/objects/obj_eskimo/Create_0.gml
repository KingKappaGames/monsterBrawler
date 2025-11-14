event_inherited();

allegiance = E_allegiance.eskimo;

HealthMax = 40;
meleeDamage = 4;

alwaysBurning = false;

#region animations
useSkeletonAnimations = true;

	//skeletonBasicItem = choose(spr_swordBranch, spr_swordHammer, spr_swordIce, spr_swordSpear);
	item = script_getItemInfo(choose(E_item.branch, E_item.hammer, E_item.broadSword, E_item.baton, E_item.woodenClub, E_item.woodCutterAxe));
	skeletonBasicItem = item.sprite;
	skeletonBasicHandRightSprite = spr_headGlove;
	skeletonBasicHandLeftSprite = spr_headGlove;
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

//image_blend = #ff1a1a;
//image_blend = #bdeeff;

#endregion

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
				script_createAttack(obj_iceBolt, x + lengthdir_x(attackCreateDist, _attackDir), y + lengthdir_y(attackCreateDist, _attackDir), _attackDir, height);
			}
		}
    },
	leave: function() {
		image_angle = 0;
	}
});

postCreate();