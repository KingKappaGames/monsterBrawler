directionAiming = point_direction(x, y, mouse_x, mouse_y);

if(keyboard_check(ord("D"))) {
	x += 5;
}
if(keyboard_check(ord("A"))) {
	x -= 5;
}
if(keyboard_check(ord("W"))) {
	y -= 5;
}
if(keyboard_check(ord("S"))) {
	y += 5;
}

camera_set_view_pos(view_camera[0], x - 480, y - 270);
camera_set_view_pos(view_camera[1], x - 480, y - 270);

if(mouse_check_button(mb_left)) {
	shotDelay--;
	if(shotDelay <= 0) {
		shotDelay = 60 / fireRate;
		shootBullet();
	}
} else if(mouse_check_button_released(mb_left)) {
	shotDelay = 60 / fireRate;
}

if(mouse_check_button_released(mb_right)) {
	instance_create_depth(mouse_x, mouse_y, depth, obj_smiteBeam);
}

if(keyboard_check_released(vk_control)) {
	repeat(2 + irandom(3)) {
		var _biggle = instance_create_depth(x, y, depth, obj_grenade);
		var _rand = directionAiming + irandom_range(-40, 40);
		_biggle.xChange = dcos(_rand) * random_range(2, 5);
		_biggle.yChange = -dsin(_rand) * random_range(2, 5);
	}
}

if(keyboard_check_pressed(vk_space)) {
	mortaring = 1;
	mortarXstart = mouse_x;
	mortarYstart = mouse_y;
}

if(keyboard_check_pressed(vk_alt)) {
	script_spawnCreature(obj_creature, 1 + irandom(10), mouse_x, mouse_y);
}

if(keyboard_check_released(vk_space)) {
	var _plane = instance_create_depth(0, 0, 0, obj_plane);
	_plane.startRunX = mortarXstart;
	_plane.startRunY = mortarYstart;
	_plane.endRunX = mouse_x;
	_plane.endRunY = mouse_y;
	_plane.getRoute();
	mortaring = 0;
}

spread *= spreadDecay;
recoil *= 1 - (1 - spreadDecay) * 5;
if(spread < spreadMinimum) {
	spread = spreadMinimum;
}

if(keyboard_check_released(ord("R"))) { 
	if(weaponType == 1) {
		weaponType = 2;
		
		fireRate = 5;
		shotDelay = 0;
		damage = 3;
		shotSpeed = 2;
	} else if(weaponType == 2) {
		weaponType = 1;
		
		fireRate = 20;
		shotDelay = 0;
		damage = 1;
		shotSpeed = 15;
	}
}

if(keyboard_check_released(ord("F"))) { window_set_fullscreen(1 - window_get_fullscreen()); }

//if(irandom(140) == 20) { 
	//instance_create_layer(0, 0, "Instances", obj_zombro); 
//}
//
//if(irandom(1200) == 1) {
	//instance_create_layer(0, 0, "Instances", obj_mother);
//}