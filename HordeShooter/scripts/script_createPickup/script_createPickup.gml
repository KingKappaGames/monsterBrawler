function script_createPickup(xx, yy, type) {
	instance_create_depth(xx, yy, -yy, type);
}