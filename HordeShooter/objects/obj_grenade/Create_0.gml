event_inherited();

range = 250;

damage = 15;
knockback = 12;
knockbackHeight = 7;
stun = 140;

friction = .12;

part_particles_create(global.sys, x, y, global.sparksParts, 5)

hitEnemy = function() {
	instance_destroy();
}