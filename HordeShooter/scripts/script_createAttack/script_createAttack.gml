function script_createAttack(type, xx, yy, directionSet, heightSet = undefined, speedMult = 1, durationMult = 1, sourceSet = id, allegianceSet = undefined, damageMult = 1, knockbackMult = 1, knockbackHeightMult = 1, stunMult = 1, targetSet = noone) {
	allegianceSet ??= sourceSet.allegiance;
	
	var _attack = instance_create_depth(xx, yy, -yy, type);
	
	with(_attack) {
		source = sourceSet;
		allegiance = allegianceSet;
		durationMax *= durationMult;
		duration = durationMax;
		
		direction = directionSet;
		speed *= speedMult;
		
		if(height == 0) { // don't update height that is already set to something that's not 0 unless passed manually, eg don't default pass
			height = heightSet ?? other.height;
		}
		
		damage *= damageMult;
		stun *= stunMult;
		knockback *= knockbackMult;
		knockbackHeight *= knockbackHeightMult;
		
		if(targetSet != noone) {
			target = targetSet;
		}
		
		spawn();
	}
		
	return _attack;
}