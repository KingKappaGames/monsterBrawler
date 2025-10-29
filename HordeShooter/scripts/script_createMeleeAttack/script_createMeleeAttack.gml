function script_createMeleeAttack(type, xx, yy, directionSet, heightSet = height, durationMult = 1, sourceSet = id, allegianceSet = undefined, damageMult = 1, knockbackMult = 1, knockbackHeightMult = 1, stunMult = 1, hitFuncSet = undefined) {
	allegianceSet ??= sourceSet.allegiance;
	
	var _depth = sourceSet.depth;
	if(directionSet < 180) {
		_depth++;
	} else {
		_depth--;
	}
	
	var _attack = instance_create_depth(xx, yy, _depth, type);
	
	with(_attack) {
		source = sourceSet;
		allegiance = allegianceSet;
		
		durationMax *= durationMult;
		duration = durationMax;
		
		image_angle = directionSet;
		image_speed = image_number / (durationMax / 60);
		height = heightSet;
		
		damage *= damageMult;
		stun *= stunMult;
		knockback *= knockbackMult;
		knockbackHeight *= knockbackHeightMult;
		
		if(!is_undefined(hitFuncSet)) {
			hitFunc = hitFuncSet;
		}
		
		spawn();
	}
		
	return _attack;
}