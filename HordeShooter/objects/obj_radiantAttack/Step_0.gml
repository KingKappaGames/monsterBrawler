if(duration > 0) {
	duration--;
	radius += increaseFlat;
	radius *= increaseMult;
	
	if(duration > hitDurationMin) {
		if(global.timer % 5 == 0) {
			hitIds = array_concat(hitIds, script_MeleeHitRadius(,,, radius, height, heightHitRange, damage, knockback,, knockbackHeight, stun, hitFunc,, hitIds));
		}
	}
} else {
	instance_destroy();
}