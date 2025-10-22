function script_createAttack(type, xx, yy, directionSet, speedSet, durationSet, sourceSet = id, allegianceSet = undefined, damageMult = 1, knockbackMult = 1, knockbackHeightMult = 1, stunMult = 1) {
	allegianceSet ??= sourceSet.allegiance;
	
	var _attack = instance_create_depth(xx, yy, -yy, type);
	
	with(_attack) {
		source = sourceSet;
		allegiance = allegianceSet;
		duration = durationSet;
		durationMax = durationSet;
		
		motion_set(directionSet, speedSet);
		
		damage *= damageMult;
		stun *= stunMult;
		knockback *= knockbackMult;
		knockbackHeight *= knockbackHeightMult;
		
		spawn();
	}
		
	return _attack;
}