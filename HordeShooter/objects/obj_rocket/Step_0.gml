event_inherited();

hspeed *= .95;
vspeed *= .95;

part_particles_create(global.sys, x, y, global.sparksParts, 1);

if(tracking > 0) {
	tracking--;
	if(!mouse_check_button(mb_left)) {
		tracking = 0;
	} else {
		var _dir = point_direction(x, y, mouse_x, mouse_y);
		var _dirChange = sign(angle_difference(_dir, image_angle));
		image_angle += _dirChange * 4;
	}
}

hspeed += lengthdir_x(.5, image_angle);
vspeed += lengthdir_y(.5, image_angle);