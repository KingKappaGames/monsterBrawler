x = room_width / 2;
y = room_height / 2;

part_system  = part_system_create();
part_emitter =  part_emitter_create(part_system);
part_type = part_type_create();

var sec = game_get_speed(gamespeed_fps)

part_emitter_region(part_system,part_emitter,x-sprite_width/2,x+sprite_width/2,y+5,y-5, ps_shape_rectangle    , ps_distr_linear);

part_emitter_stream(part_system,part_emitter,part_type,-3);
part_type_alpha3(part_type,0,1,0)
part_type_blend(part_type,1)

part_type_sprite(part_type,spr_plus,0,0,0)
part_type_life(part_type,0,120);
part_type_speed(part_type,0.2,1.4,-0.01,0);
part_type_direction(part_type,90,90,0,0)
part_type_orientation(part_type,90,90,0,0,0)
part_type_size(part_type,0.8,1,-0.05,0)

weaponType = 1; //1 machine gun, 2 rockets, 3 ???

fireRate = 20;
shotDelay = 0;
damage = .7;
shotSpeed = 15;

spreadMinimum = 0;
spread = 3;
spreadDecay = .97;

directionAiming = 0;
recoil = 0;

mortaring = 0;
mortarXstart = 0;
mortarYstart = 0;

global.sys = part_system_create_layer("Instances", false);
global.sparksParts = part_type_create();
part_type_size(global.sparksParts, .1, .2, 0, 0);
part_type_alpha2(global.sparksParts, 1, .1);
part_type_shape(global.sparksParts, pt_shape_square);
part_type_direction(global.sparksParts, 0, 360, 0, 0);
part_type_speed(global.sparksParts, .1, .5, 0, 0);
part_type_life(global.sparksParts, 30, 90);

global.sparksPartsWide = part_type_create();
part_type_size(global.sparksPartsWide, .1, .15, 0, 0);
part_type_alpha2(global.sparksPartsWide, 1, 0);
part_type_shape(global.sparksPartsWide, pt_shape_square);
part_type_direction(global.sparksPartsWide, 0, 360, 0, 0);
part_type_speed(global.sparksPartsWide, .3, 8, 0, 0);
part_type_life(global.sparksPartsWide, 17, 35);

global.sparksPartsThin = part_type_create();
part_type_size(global.sparksPartsThin, .07, .07, -.0001, 0);
part_type_alpha2(global.sparksPartsThin, .8, 0);
part_type_shape(global.sparksPartsThin, pt_shape_square);
part_type_orientation(global.sparksPartsThin, 0, 360, 0, 0, 0);
part_type_life(global.sparksPartsThin, 25, 30);

global.sparksPartsMortarSmall = part_type_create();
part_type_size(global.sparksPartsMortarSmall, .05, .3, -.001, 0);
part_type_alpha2(global.sparksPartsMortarSmall, 1, 0);
part_type_shape(global.sparksPartsMortarSmall, pt_shape_line);
part_type_direction(global.sparksPartsMortarSmall, 20, 160, 0, 0);
part_type_orientation(global.sparksPartsMortarSmall, 0, 0, 0, 0, 1);
part_type_speed(global.sparksPartsMortarSmall, .3, 5, 0, 0);
part_type_life(global.sparksPartsMortarSmall, 21, 120);
part_type_gravity(global.sparksPartsMortarSmall, .015, 270);

shootBullet = function() {
	var _bulletType = obj_bullet;
	var _spawnArea = 0;
	if(weaponType == 2) {
		_bulletType = obj_rocket;
		_spawnArea = 50;
	}
	var _bullet = instance_create_layer(x + dcos(directionAiming) * 16 + irandom_range(-_spawnArea, _spawnArea), y - dsin(directionAiming) * 16 + irandom_range(-_spawnArea, _spawnArea), "Instances", _bulletType);
	_bullet.xChange = dcos(directionAiming + irandom_range(-spread, spread)) * shotSpeed;
	_bullet.yChange = -dsin(directionAiming + irandom_range(-spread, spread)) * shotSpeed;
	_bullet.damage = damage * _bullet.damage;
	_bullet.image_angle = point_direction(0, 0, _bullet.xChange, _bullet.yChange);
	
	spread += 1;
	recoil += 2;
}

cameraOne = camera_create_view(0, 0, 1920, 1080);
//cameraTwo = camera_create_view(0, 0, 960, 540);

view_set_camera(0, cameraOne); //view_camera[0] or [1] worked
//view_set_camera(1, cameraTwo);

view_enabled = 1;
view_visible[0] = true;
//view_visible[1] = true;

view_xport[0] = 0;
view_yport[0] = 0;
view_wport[0] = 1920;
view_hport[0] = 1080;

//view_xport[1] = 960;
//view_yport[1] = 0;
//view_wport[1] = 960;
//view_hport[1] = 540;

//window_set_size(1920, 1080);
//surface_resize(application_surface, 1920, 1080);