event_inherited();

damage = 3;
knockback = 7;
knockbackHeight = 4;
stun = 60;

durationMax = 240;

speed = 10;

hitSingle = true;

tracking = 150;

part_particles_create(global.sys, x, y, global.sparksParts, 5)

hitEnemy = function(hitId) {
	
}

hit = function() {
	script_AOEDamageHit(,,, 200, damage, knockback,, knockbackHeight, stun);
	part_particles_create(global.sys, x, y, global.sparksPartsWide, 300);
	script_createEffectWave(x, y, 50, 10, 30, .84,, 10, -.25);
	instance_destroy();
}