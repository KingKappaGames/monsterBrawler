x += xChange;
y += yChange;

xChange *= .95;
yChange *= .95;
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

xChange += dcos(image_angle) / 2;
yChange -= dsin(image_angle) / 2;

with(obj_zombro) {
	if(abs(x - other.x) < 10) {
		if(abs(y - other.y) < 10) {
			other.hitEnemy(id);
		}
	}
}

with(obj_mother) {
	if(abs(x - other.x) < 20) {
		if(abs(y - other.y) < 20) {
			other.hitEnemy(id);
			script_createHitNum(other.damage);
		}
	}
}

if(x < -100 || x > room_width + 100) { instance_destroy(); }

if(y < -100 || y > room_height + 100) { instance_destroy(); }