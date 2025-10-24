event_inherited();

damage = 5;
knockback = 0;
knockbackHeight = 0;
stun = 0;

durationMax = 90;

speed = 14;

hitSingle = false;

part_particles_create(global.sys, x, y, global.sparksPartsMortarSmall, 5);

hitEnemy = function(hitId) {
	
}

hit = function() {
	audio_play_sound(snd_iceSpellImpact, 0, 0);
	
	script_AOEDamageHit(,,, 200, damage, knockback,, knockbackHeight, stun,,, freezeFunc);
	OWP_createPartExtColor(global.partThickHaze, x, y, 5, #bbffff,, 70, 0, 1);
	part_type_speed(global.partStar, 2, 5, -.125, 0);
	OWP_createPartExtColor(global.partStar, x, y, 20, #ccffff,, 20, 20, 5);
	part_type_speed(global.partOverwrittenTrailer, 3, 5, 0, 0);
	OWP_createPartExt(global.partOverwrittenTrailer, x, y, 12,, 0, 10, 1);
	
	instance_destroy();
}

freezeFunc = function(damageAOEDropOff, targetId) {
	if(.3 + random(.8) < damageAOEDropOff) {
		targetId.SM.change("frozen");
	}
}