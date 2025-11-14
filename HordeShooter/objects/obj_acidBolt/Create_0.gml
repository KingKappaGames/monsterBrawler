event_inherited();

damage = 8;
knockback = 9;
knockbackHeight = 3;
stun = 80;

durationMax = 90;

speed = 13;

hitSingle = false;

part_particles_create(global.sys, x, y, global.sparksPartsMortarSmall, 5);

hitEnemy = function(hitId) {
	
}

hit = function() {
	audio_play_sound(snd_acidSplash, 0, 0);
	
	script_AOEDamageHit(,,, 250, damage, knockback,, knockbackHeight, stun,,, elementFunc);
	OWP_createPartExtColor(global.partThickHaze, x, y, 40, #88ff88,, 90, 0, 1);
	part_type_speed(global.partStar, 2, 5, -.125, 0);
	OWP_createPartExtColor(global.partStar, x, y, 20, #ffffaa,, 20, 20, 5);
	part_type_speed(global.partOverwrittenTrailer, 3, 7, 0, 0);
	OWP_createPartExt(global.partOverwrittenTrailer, x, y, 20,, 0, 10, 1);
	
	instance_destroy();
}

elementFunc = function(damageAOEDropOff, targetId) {
	if(random(1) < damageAOEDropOff) {
		targetId.applyAcidic(240 + 240 * damageAOEDropOff);
	}
}