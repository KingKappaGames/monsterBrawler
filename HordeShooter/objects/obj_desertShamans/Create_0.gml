event_inherited();

allegiance = E_allegiance.desert;

HealthMax = 24;

meleeDamage = 11;
magicDamage = 1;
knockback = 1;
knockbackHeight = 1;
stun = 1;

alwaysBurning = false;

attackRangeRangedMax = 500;
attackRangeRangedMin = 250;

#region animations
useSkeletonAnimations = true;

	//skeletonBasicItem = choose(spr_swordDesertStaff, spr_swordDesertStaff);//choose(spr_swordFantasy, spr_swordBranch, spr_swordBlackPoker, spr_swordIce);
	item = script_getItemInfo(choose(E_item.branch, E_item.hammer, E_item.broadSword, E_item.baton, E_item.woodenClub));
	skeletonBasicItem = item.sprite;
	skeletonBasicHandRightSprite = spr_flameMonsterHandLeft;
	skeletonBasicHandLeftSprite = spr_flameMonsterHandRight;
	skeletonBasicHeadSprite = spr_desertShamanHead;
	skeletonBasicBodySprite = spr_monkBodyHit; // not used

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

image_blend = #ccaa55;

#endregion

SM.add("attackRanged", {
    enter: function(duration = 120) {
		//die animation
		script_setEventTimer(duration);
		image_angle = 20;
    },
    step: function() {
		stateTimer--;
		if(stateTimer <= 0) {
			SM.change("chase");
		} else if(stateTimer == round(stateTimerMax * .3)) {
			if(instance_exists(agroId)) {
				script_createAttack(obj_tornado, agroId.x + irandom_range(-200, 200), agroId.y + irandom_range(-200, 200), 0, 0);
			}
		}
    },
	leave: function() {
		image_angle = 0;
	}
});

postCreate();