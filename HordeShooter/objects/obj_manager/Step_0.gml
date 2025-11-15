global.timer++;

if(keyboard_check_released(ord("O"))) {
	autoSpawn = !autoSpawn;
}

if(keyboard_check_released(vk_f3)) {
	global.showDebug = !global.showDebug;
}

if(keyboard_check_released(ord("F"))) { window_set_fullscreen(1 - window_get_fullscreen()); }

var _camScaleChange = InputCheck(INPUT_VERB.CAMERAZOOMOUT) - InputCheck(INPUT_VERB.CAMERAZOOMIN);
if(_camScaleChange != 0) {
	var _cam = view_camera[0];
	global.cameraScale = clamp(global.cameraScale * (1 + _camScaleChange * .01), .1, .75);
	var _scaleVal = global.cameraScale;

	var _centerX = camera_get_view_x(_cam) + camera_get_view_width(_cam) / 2;
	var _centerY = camera_get_view_y(_cam) + camera_get_view_height(_cam) / 2;

	camera_set_view_size(_cam, _scaleVal * camWidthBase, _scaleVal * camHeightBase);
	camera_set_view_pos(_cam, _centerX - camera_get_view_width(_cam) / 2, _centerY - camera_get_view_height(_cam) / 2);
}

if(autoSpawn) {
	if(irandom(8) == 0) {
		if(irandom(40) == 0 && instance_number(obj_knight) > 10) {
			script_spawnCreature(obj_darkPriest, irandom_range(1, 5),,, true); // spawn powerful unit to offset battle
		} else if(irandom(26) == 0 && instance_number(obj_barbarian) > 10) {
			script_spawnCreature(obj_priest, irandom_range(1, 5),,, true); // spawn powerful unit to offset battle
		} else {
			script_spawnCreature(choose(obj_barbarian, obj_knight, obj_eskimo, obj_demon, obj_jungleWarrior, obj_desertWarrior, obj_desertShamans, obj_scarecrow), irandom_range(1, 5),,, true);
		}
	}
}

updateRooms();