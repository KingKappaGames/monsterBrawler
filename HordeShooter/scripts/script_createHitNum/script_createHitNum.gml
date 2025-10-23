function script_createHitNum(number) {
	var _num = instance_create_depth(x, y, -5000, obj_damageNumber);
	with(_num) {
		display = number;
		motion_set(irandom(180), random_range(3, 6));
		friction = .4;
		gravity = .3;
		gravity_direction = 90;
	}
	
	return _num;
}