/// @desc  Returns a single id for an object of a given type within a range, either the closest or farthest.
/// @param {id.instance} [sourceId]=id  The instance to run the check, aka the origin point and agro reference
/// @param {real} [range]=agroRange  The max range to seek the target from
/// @param {bool} [farthestOverNearest]=false  If 0 then returns the closest, default, if 1 returns the farthest
/// @param {asset.gmobject} [targets]=obj_creature  This is a pass through value for things to check, can be anything collision checks can be, objects, instances, arrays, tilemaps(?)
/// @param {any*} [sourceAllegiance]  If you want to force an agro for this check then sure, go ahead and pass the goal allegiance here
/// @param {real} [xx]=x If you want to check a given position then pass x to check here
/// @param {real} [yy]=y If you want to check a given position then pass y to check here
/// @returns {id} The found instance to have agro with
function script_findAgroTarget(sourceId = id, range = agroRange, farthestOverNearest = false, targets = obj_creature, sourceAllegiance = undefined, xx = x, yy = y){	
	var _agroCheckList = ds_list_create();
	var _result = noone;
	
	with(sourceId) {
		sourceAllegiance ??= allegiance;
		var _checkCount = collision_circle_list(xx, yy, range, targets, false, true, _agroCheckList, true);
		if(farthestOverNearest == false) { // get closest!
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