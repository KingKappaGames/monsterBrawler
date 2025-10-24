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
		damage = 1;
		shotSpeed = 1;
	}
}