depth = -y;

if(homingDuration > 0) {
	homingDuration--;
	
	if(instance_exists(homingTargetId)) {
		var _directionChange = angle_difference(point_direction(x, y, homingTargetId.x, homingTargetId.y), direction) * .02 * homingStrengthMult;
		direction += _directionChange;
	} else {
		homingTargetId = script_findAgroTarget(source, homingRange, false, obj_creature, allegiance, x + hspeed * 20, y + vspeed * 20);
	}
}

var _hitCount = collision_circle_list(x, y, hitRadius, obj_creature, false, false, hitList, false);

var _hitId;
var _hitSomething = false;
for(var _i = 0; _i < _hitCount; _i++) {
	_hitId = hitList[| _i];
	
	if(source != _hitId) {
		if(script_judgeAllegiance(allegiance, _hitId.allegiance) < .5) {
			if(abs(height - _hitId.height) < heightHitRange) {
				hitEnemy(_hitId);
				
				_hitSomething = true;
				
				if(hitSingle) {
					break;
				}
			}
		}
	}
}

if(_hitCount != 0) {
	ds_list_clear(hitList); // only clear if anything's in there anyway..
	
	if(_hitSomething && hitStopOn) {
		hit();
	}
}

event_inherited();