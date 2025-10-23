event_inherited();

part_particles_create(global.sys, x, y, global.sparksParts, 1);

if(irandom(5) == 0) {
	var _hit = instance_nearest(x, y, obj_creature);
	if(point_distance(x, y, _hit.x, _hit.y) < 100) {
		if(script_judgeAllegiance(allegiance, _hit.allegiance) < .5) {
			hitEnemy();
		}
	}
}