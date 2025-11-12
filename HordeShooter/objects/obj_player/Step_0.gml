event_inherited();

camera_set_view_pos(view_camera[0], x - camera_get_view_width(view_camera[0]) * .5, y - camera_get_view_height(view_camera[0]) * .5);

if(keyboard_check_released(ord("R"))) { 
	if(weaponType == 1) {
		weaponType = 2;
		
		fireRate = 5;
		shotDelay = 0;
		damage = 3;
		shotSpeed = 1;
	} else if(weaponType == 2) {
		weaponType = 3;
		
		fireRate = 4;
		shotDelay = 0;
		damage = 1;
		shotSpeed = 1;
	} else if(weaponType == 3) {
		weaponType = 4;
		
		fireRate = 3;
		shotDelay = 0;
		damage = 1;
		shotSpeed = 1;
	} else if(weaponType == 4) {
		weaponType = 1;
		
		fireRate = 20;
		shotDelay = 0;
		damage = 3;
		shotSpeed = 1;
	}
}

spread *= spreadDecay;
recoil *= 1 - (1 - spreadDecay) * 5;
if(spread < spreadMinimum) {
	spread = spreadMinimum;
}

if(keyboard_check_released(ord("H"))) {
	script_createAttack(obj_thunderCloud, x + irandom_range(-200, 200), y + irandom_range(-200, 200), 0);
}

if(keyboard_check_released(vk_f1)) {
	script_createPickup(mouse_x, mouse_y, obj_pickup);
}

if(keyboard_check_pressed(vk_alt)) {
	script_spawnCreature(choose(obj_barbarian, obj_knight), 1 + irandom(10), mouse_x, mouse_y);
}

if(keyboard_check_pressed(vk_f7)) {
	script_spawnCreature(obj_darkPriest, 1 + irandom(10), mouse_x, mouse_y);
}
if(keyboard_check_pressed(vk_f8)) {
	script_spawnCreature(obj_priest, 1 + irandom(10), mouse_x, mouse_y);
}