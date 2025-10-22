function script_spawnCreature(type, level, xx, yy, spawnRandomAroundCam = false) {
	if(spawnRandomAroundCam) {
		var _cam = global.cam;
		var _camX = camera_get_view_x(_cam);
		var _camY = camera_get_view_x(_cam);
		var _camW = camera_get_view_width(_cam);
		var _camH = camera_get_view_height(_cam);
		
		if(is_undefined(xx) && is_undefined(yy)) {
			if(irandom(1) == 1) {
				xx = _camX + choose(0, _camW);
				yy = _camY + irandom(_camH);
			} else {
				xx = _camX + irandom(_camW);
				yy = _camY + choose(0, _camH);
			}
		} else {
			xx ??= _camX + choose(0, _camW);
			yy ??= _camY + choose(0, _camH);
		}
	}
	
	var _creature = instance_create_depth(xx, yy, -yy, type);
	_creature.HealthMax *= sqrt(3 + level) / 2;
	
	_creature.refreshCondition();
	_creature.spawn();
}