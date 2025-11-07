function script_createAttackRadiant(type, xx, yy, heightSet = height, heightRange = 50, durationSet = 1, sizeInitial, sizeGrowFlat = 0, sizeGrowMult = 1, color = c_white, sourceSet = id, allegianceSet = undefined, damageMult = 1, knockbackMult = 1, knockbackHeightMult = 1, stunMult = 1, depthForce = -yy) {
	allegianceSet ??= sourceSet.allegiance;
	
	var _attack = instance_create_depth(xx, yy, depthForce, type);
	
	with(_attack) {
		source = sourceSet;
		allegiance = allegianceSet;
		durationMax = durationSet;
		duration = durationMax;

		height = heightSet;
		heightHitRange = heightRange;
		
		radius = sizeInitial;
		increaseFlat = sizeGrowFlat;
		increaseMult = sizeGrowMult;
		image_blend = color;
		
		damage *= damageMult;
		stun *= stunMult;
		knockback *= knockbackMult;
		knockbackHeight *= knockbackHeightMult;
		
		spawn();
	}
		
	return _attack;
}