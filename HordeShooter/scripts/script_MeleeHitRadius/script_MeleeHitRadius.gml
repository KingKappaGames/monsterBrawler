//-2 for itemResponsible means don't check for effects, -1 means no item in particular just check all items, and 0-12 represent gear positions (use enum!)
//hitInfo = [damageArray, blockable, absolute, statusInfoArray, statusChance, itemResponsible];
#region contains jsdoc stuff
///@desc pretty self explanatory, use this script to attempt a hit on all objects of the given type within a circular range, no drop off. Knockback direction will default to radial.
///@param allegianceOverride 
///@param xx            
///@param yy
///@param radius
///@param hitInfo array that contains |dmgArr-blockable-absolute-statusInfo-status%Dec-itemResponsible|
///@param knockbackStrength The strength of pushback on whatever thing gets hit.
///@param knockbackDirection The direction of the pushback on the hit thing.
///@param knockbackHeight The height component of the knockback
///@param stun The poise damage to do with this attack
///@param hitFunc The function to run with the hit objects TAKES HIT THING AND HITTER hitFunc(target, source)
///@param targets This value is passed through to the collision scripts that game maker uses, so it can be keywords, objects, arrays, tile sets, ect. Direct transfer so whatever gm uses goes here     
///@param {ARRAY} exclusions This is an array of white listed instances that if the hit id is contained will not hit
#endregion
function script_MeleeHitRadius(allegianceOverride = allegiance, xx = x, yy = y, radius = 0, heightSet = height, heightRange = heightHitRange, damage = 0, knockbackStrength = 0, knockbackDirection = undefined, knockbackHeight = 0, stun = undefined, hitFunc = undefined, targets = obj_creature, exclusions = []) {
	if(is_undefined(stun)) {
		stun = power(knockbackStrength + knockbackHeight, 1.4);
	}
		
	var _hitList = ds_list_create();
	var _hitCount = collision_circle_list(xx, yy, radius, targets, false, true, _hitList, false); // not ordered idk
	
	var _hits = [];
	var _hitNum = 0;
	
	for(var _hitI = 0; _hitI < _hitCount; _hitI++) { // for each collided game object
		with(_hitList[| _hitI]) { // with hit thing
			if(!intangible) { 
				if(abs(heightSet - height) < heightRange) {
					if(!array_contains(exclusions, id)) { // if this target is not in the exclusions passed in (don't hit white listed things, basically)
						if(object_is_ancestor(object_index, obj_creature) && script_judgeAllegiance(allegianceOverride, allegiance) < .5) {
							
							if(!is_undefined(hitFunc)) {
								hitFunc(_hitList[| _i], other);
							}
							
							takeDamage(damage, is_undefined(knockbackDirection) ? point_direction(xx, yy, x, y) : knockbackDirection, knockbackStrength, knockbackHeight, stun);
							_hits[_hitNum] = id; // add to the hit registry
							_hitNum++;
						}
					}
				}
			}
		}
	}
	
	ds_list_destroy(_hitList);
	
	return _hits;
}

