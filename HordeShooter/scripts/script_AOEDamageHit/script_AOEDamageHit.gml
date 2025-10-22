///@desc This is a general purpose script used to hit targets in an area but reduce the effect of the hit based on distance. All passed values will be reduced with distance (depends on fall off equation?)
///@param allegianceSet This is the agro target, a team set.
///@param xx The center x of the area
///@param yy The center y of the area
///@param radius The radius of the area to affect, fall off being 1-0 within this range
///@param damage This is a collection of all the damage types, at the moment being, physical, magic, fire, frost, lightning, light, dark. Maybe add more. 
///@param knockbackStrength The strength to knockback enemies (max, falls off)
///@param knockbackDirection The direction to knockback enemies (if wanted, left blank/-1 will simply knock away from center)
///@param stun This includes the strength of the stun and the verticality of the stun.
///@param targets This is what to hit. Includes enemies and many types of game objects that are destructable. 
///@param exclusions Array of whitelisted instance ids
function script_AOEDamageHit(allegianceSet = allegiance, xx = x, yy = y, radius = 0, damage = 0, knockbackStrength = 0, knockbackDirection = undefined, knockbackHeight = 0, stun = undefined, targets = obj_creature, exclusions = []){
	var _calcDir = 1;
	if(knockbackDirection != -1) { // cancel out the need to get direction if one has been passed already
		_calcDir = 0;
	}
		
	var _hitList = ds_list_create();
	var _hitCount = collision_circle_list(xx, yy, radius, targets, false, true, _hitList, false); // not ordered idk
	
	var _hits = [];
	var _hitNum = 0;
	
	for(var _hitI = 0; _hitI < _hitCount; _hitI++) { // for each collided game object
		with(_hitList[| _hitI]) { // with hit thing
			if(!intangible) { 
				if(!array_contains(exclusions, id)) { // if this target is not in the exclusions passed in (don't hit white listed things, basically)
					if(object_is_ancestor(object_index, obj_creature)) {
						if(script_judgeAllegiance(allegianceSet, allegiance) > .5) {
							continue; // if is NOT friendly (and only creatures can be friendly) then skip this creature
						}
					}
								
					var _aoeDropOff = clamp(1 - (point_distance(xx, yy, x, y) / radius), .1, 1); // this is what would determine the damage at a given distance, could be switched to an equation or some other sort of adjustment
				
					knockbackDirection ??= point_direction(xx, yy, x, y);
			
					var _knockbackDone = knockbackStrength * _aoeDropOff;
					
					if(is_undefined(stun)) {
						stun = power(_knockbackDone, 1.5);
					} else {
						stun *= _aoeDropOff;
					}
			
					takeDamage(ceil(damage * _aoeDropOff), knockbackDirection, _knockbackDone, knockbackHeight * _aoeDropOff, stun);
					_hits[_hitNum] = id; // add to the hit registry
					_hitNum++;
				}
			}
		}
	}
	
	ds_list_destroy(_hitList);
	
	return _hits;
}