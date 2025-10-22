xChange = random_range(-1, 1);
yChange = 0;
damage = 10;

groundY = room_height / 2;

hitEnemy = function() {
	with(obj_zombro) {
		var _dist = point_distance(x, y, other.x, other.y)
		if(_dist < 300) {
			var _hitDir = point_direction(other.x, other.y, x, y);
			var _mag = sqr((300 - _dist) / 300);
			xChange += dcos(_hitDir) * _mag * 4;
			yChange -= dsin(_hitDir) * _mag * 4;
			Health -= other.damage * _mag;
			script_createHitNum(other.damage * _mag);
			if(Health < 0) {
				instance_destroy();
			}
		}
	}
	
	with(obj_mother) {
		var _dist = point_distance(x, y, other.x, other.y)
		if(_dist < 300) {
			var _hitDir = point_direction(other.x, other.y, x, y);
			var _mag = sqr((300 - _dist) / 300);
			xChange += dcos(_hitDir) * _mag * 4;
			yChange -= dsin(_hitDir) * _mag * 4;
			Health -= other.damage * _mag;
			script_createHitNum(other.damage);
			if(Health < 0) {
				instance_destroy();
			}
		}
	}
	
	part_particles_create(global.sys, x, y, global.sparksParts, 13);
	
	instance_destroy();
}