#region jsdoc stuff
///@desc This script is similar to a hitbox script but simply returns all hit indexs with validity checking, instead of hitting them for you, (the rotated rect melee script uses this to get it's targets and hits them all)
/// @param startX
/// @param startY
/// @param directionCheck
/// @param thickness
/// @param length
/// @param notMe
/// @param ordered
/// @param allegianceSet This function checks the possible targets against their agro to only hit the targets that should be hit, aka enemies or such.
/// @param targets the things to check with "with" so type arrays specific id. Has to be related to game object.
///@param exclusions A white list of instances (just instances?) to not hit
#endregion
function script_CollisionRectangleRotated(startX, startY, directionCheck, thickness, length, notMe, ordered = false, allegianceSet = undefined, targets = obj_creature, exclusions = []){
	if(object_is_ancestor(object_index, obj_attack)) {
		var _self = source; // get source Id for thing being used, so spells won't hit their creator
		allegianceSet ??= source.allegiance;
	} else {
		var _self = id; // what does not me do at this point?
		allegianceSet ??= allegiance;
	}
	
	var _hitList = script_GetSensorCollisions(startX, startY, thickness, length, directionCheck, targets, ordered);
	var _hitCount = ds_list_size(_hitList); // initial count of collisions
	
	var _hits = [];
	var _hitNum = 0; // count of resulting hits done
	
	for(var _hitI = 0; _hitI < _hitCount; _hitI++) { // for each collided game object
		with(_hitList[| _hitI]) {
			if(!intangible) {
				if(!array_contains(exclusions, id)) { // if this target is not in the exclusions passed in (don't hit white listed things, basically)
					if(object_is_ancestor(object_index, obj_creature)) {
						if(script_judgeAllegiance(allegianceSet, allegiance) > .5) {
							continue; // if is NOT friendly (and only creatures can be friendly) then skip this creature
						}
					}
				
					_hits[_hitNum] = id; // add to the hit registry
					_hitNum++;
				}
			}
		}
	}
	
	ds_list_destroy(_hitList);
	
	return _hits;
}