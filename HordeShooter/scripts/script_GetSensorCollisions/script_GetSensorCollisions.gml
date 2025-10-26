///@desc much like the other functions this will use the provided shape to find collisions
function script_GetSensorCollisions(startX, startY, width, height, angle, targets, ordered){
	if(!instance_exists(obj_RectangleSensor)) {
		instance_create_depth(0, 0, 0, obj_RectangleSensor);
	}

	// maybe this should have options for which shape to use? Eh
 
	return obj_RectangleSensor.getCollisions(startX, startY, width, height, angle, targets, ordered);
}