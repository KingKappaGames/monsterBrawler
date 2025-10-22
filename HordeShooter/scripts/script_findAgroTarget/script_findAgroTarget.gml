///@desc Returns a single id for an object of a given type within a range, either the closest or farthest.
///@param sourceId The instance to run the check, aka the origin point and agro reference
///@param range The max range to seek the target from
///@param nearestOrFarthest If 0 then returns the closest, default, if 1 returns the farthest
///@param targets This is a pass through value for things to check, can be anything collision checks can be, objects, instances, arrays, tilemaps(?)
///@param sourceAllegiance If you want to force an agro for this check then sure, go ahead and pass the goal allegiance here
function script_findAgroTarget(sourceId = id, range = agroRange, nearestOrFarthest = 0, targets = obj_creature, sourceAllegiance = undefined){	
	var _agroCheckList = ds_list_create();
	var _result = noone;
	
	with(sourceId) {
		sourceAllegiance ??= allegiance;
		var _checkCount = collision_circle_list(x, y, range, targets, false, true, _agroCheckList, true);
		if(nearestOrFarthest == 0) { // get closest!
			for(var _checkI = 0; _checkI < _checkCount; _checkI++) {
				var _checkId = _agroCheckList[| _checkI];
				
				if(_checkId.Health > 0) {
					if(script_judgeAllegiance(sourceAllegiance, _checkId.allegiance) < .5) {
						_result = _checkId;
						break;
					}
				}
			}
		} else { // get furthest
			for(var _checkI = _checkCount - 1; _checkI > -1; _checkI--) {
				var _checkId = _agroCheckList[| _checkI];
				
				if(_checkId.Health > 0) {
					if(script_judgeAllegiance(sourceAllegiance, _checkId.allegiance) < .5) {
						_result = _checkId;
						break;
					}
				}
			}
		}
	}
	
	ds_list_destroy(_agroCheckList);
	
	return _result;
}