if(pickupDelay <= 0) {
	var _near = instance_nearest(x, y, obj_creature);
	if(_near != noone) { // pick up the item by nearby creature, whoever it is
		var _dist = point_distance(x, y, _near.x, _near.y);
		if(_dist < range) {
			pickUp(_near);
		}
	}
} else {
	pickupDelay--;
}

duration--;
if(duration <= 0) {
	instance_destroy();
}