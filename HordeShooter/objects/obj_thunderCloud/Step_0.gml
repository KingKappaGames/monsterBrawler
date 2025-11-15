if(duration > 0) {
	duration--;
	
	if(duration > hitDurationMin) {
		if(duration % 3 == 0) {
			
			ds_list_clear(hitList);
		
			var _affectedCount = collision_circle_list(x, y, radius * 1.5 + 220, obj_creature, false, false, hitList, false);
			for(var _i = 0; _i < _affectedCount; _i++) {
				with(hitList[| _i]) {
					if(irandom(120) == 0) {
						if(script_judgeAllegiance(allegiance, other.allegiance) < .5) {
							script_createAttack(obj_lightningStrike, x, y, 0, 0, 0,, other,,,,,, id);
						}
					}
				}
			}
			
			//hitIds = array_concat(hitIds, script_MeleeHitRadius(,,, radius, height, heightHitRange, damage, knockback,, knockbackHeight, stun, hitFunc,, hitIds));
			//if(global.timer % 30 == 0) {
				//hitIds = []; // reset hittable things 
			//}
		}
	}
} else {
	instance_destroy();
}