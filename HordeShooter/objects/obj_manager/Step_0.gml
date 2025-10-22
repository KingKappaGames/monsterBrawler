if(keyboard_check_released(ord("O"))) {
	autoSpawn = !autoSpawn;
}

if(keyboard_check_released(vk_f3)) {
	global.showDebug = !global.showDebug;
}

if(autoSpawn) {
	if(irandom(30) == 0) {
		if(irandom(10) == 0 && instance_number(obj_knight) > 15) {
			script_spawnCreature(obj_darkPriest, irandom_range(1, 5),,, true); // spawn powerful unit to offset battle
		} else if(irandom(10) == 0 && instance_number(obj_barbarian) > 15) {
			script_spawnCreature(obj_priest, irandom_range(1, 5),,, true); // spawn powerful unit to offset battle
		} else {
			script_spawnCreature(choose(obj_barbarian, obj_knight), irandom_range(1, 5),,, true);
		}
	}
}