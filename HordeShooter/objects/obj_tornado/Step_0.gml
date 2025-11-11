if(duration > 0) {
	duration--;
	
	if(duration > hitDurationMin) {
		if(global.timer % 5 == 0) {
			
			ds_list_clear(swirlList);
		
			var _swirlCount = collision_circle_list(x, y, radius * 1.5 + 220, obj_creature, false, false, swirlList, false);
			var _swirlId;
			var _tX = x;
			var _tY = y;
			var _pushDir;
			for(var _i = 0; _i < _swirlCount; _i++) {
				with(swirlList[| _i]) {
					_pushDir = point_direction(x, y, _tX, _tY) + 90;
					motion_add(_pushDir, 3.2);
					poise -= 2;
					if(irandom(180) == 0) {
						takeDamage(0, _pushDir, 4, 2, 10,, false);
					}
				}
			}
			
			hitIds = array_concat(hitIds, script_MeleeHitRadius(,,, radius, height, heightHitRange, damage, knockback,, knockbackHeight, stun, hitFunc,, hitIds));
			if(global.timer % 30 == 0) {
				hitIds = []; // reset hittable things 
			}
		}
	}
} else {
	instance_destroy();
}