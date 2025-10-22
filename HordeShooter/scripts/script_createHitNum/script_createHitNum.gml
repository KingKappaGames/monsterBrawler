function script_createHitNum(number) {
	var _num = instance_create_depth(x, y, -5000, obj_damageNumber);
	with(_num) {
		display = number;
		motion_set(irandom(180), random_range(sqrt(number) * 1.5, sqrt(number) * 4));
		friction = .4;
		gravity = .3;
		gravity_direction = 90;
	}
	
	return _num;
}