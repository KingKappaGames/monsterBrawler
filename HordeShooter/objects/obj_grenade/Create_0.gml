event_inherited();

range = 250;

damage = 15;
knockback = 12;
knockbackHeight = 7;
stun = 140;

durationMax = 1200;

speed = 10;

friction = .12;

part_particles_create(global.sys, x, y, global.sparksParts, 5)

hitEnemy = function() {
	
}

hit = function() {
	script_AOEDamageHit(,,, range, damage, knockback,, knockbackHeight, stun);
	part_particles_create(global.sys, x, y, global.sparksPartsWide, 300);
	script_createEffectWave(x, y, 50, 10, 30, .84,, 10, -.25);
	instance_destroy();
}