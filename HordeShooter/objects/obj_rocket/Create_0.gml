xChange = 0;
yChange = 0;
damage = .6;

tracking = 380;

part_particles_create(global.sys, x, y, global.sparksParts, 5)

hitEnemy = function(hitId) {
	with(obj_zombro) {
		var _dist = point_distance(x, y, other.x, other.y)
		if(_dist < 300) {
			var _hitDir = point_direction(other.x, other.y, x, y);
			var _mag = sqr((300 - _dist) / 300);
			xChange += dcos(_hitDir) * _mag * 10;
			yChange -= dsin(_hitDir) * _mag * 10;
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
			xChange += dcos(_hitDir) * _mag * 10;
			yChange -= dsin(_hitDir) * _mag * 10;
			Health -= other.damage * _mag;
			script_createHitNum(other.damage);
			if(Health < 0) {
				instance_destroy();
			}
		}
	}
	
	part_particles_create(global.sys, x, y, global.sparksPartsWide, 9);
	
	instance_destroy();
}