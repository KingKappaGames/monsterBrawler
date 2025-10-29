function script_createAttack(type, xx, yy, directionSet, heightSet = height, speedMult = 1, durationMult = 1, sourceSet = id, allegianceSet = undefined, damageMult = 1, knockbackMult = 1, knockbackHeightMult = 1, stunMult = 1) {
	allegianceSet ??= sourceSet.allegiance;
	
	var _attack = instance_create_depth(xx, yy, -yy, type);
	
	with(_attack) {
		source = sourceSet;
		allegiance = allegianceSet;
		durationMax *= durationMult;
		duration = durationMax;
		
		direction = directionSet;
		speed *= speedMult;
		height = heightSet;
		
		damage *= damageMult;
		stun *= stunMult;
		knockback *= knockbackMult;
		knockbackHeight *= knockbackHeightMult;
		
		spawn();
	}
		
	return _attack;
}