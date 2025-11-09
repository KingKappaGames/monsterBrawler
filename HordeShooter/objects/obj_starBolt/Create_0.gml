event_inherited();

sprite_index = spr_starShape;

image_xscale = 1.6;
image_yscale = 1.6;

spinSpeed = random_range(-25, 25);

damage = 8;
knockback = 9;
knockbackHeight = 3;
stun = 80;

durationMax = 105;

homingDuration = 42;
homingStrengthMult = 1.5;

speed = 12;

hitSingle = false;

//part_particles_create(global.sys, x, y, global.sparksPartsMortarSmall, 5);

hitEnemy = function(hitId) {
	
}

hit = function() {
	audio_play_sound(snd_acidSplash, 0, 0);
	
	script_AOEDamageHit(,,, 250, damage, knockback,, knockbackHeight, stun,,, elementFunc);
	part_type_speed(global.partStar, 2, 5, -.125, 0);
	OWP_createPartExtColor(global.partStar, x, y, 20, #ffffaa,, 20, 20, 5);
	part_type_speed(global.partOverwrittenTrailer, 3, 7, 0, 0);
	OWP_createPartExt(global.partOverwrittenTrailer, x, y, 20,, 0, 10, 1);
	
	instance_destroy();
}

elementFunc = function(damageAOEDropOff, targetId) {
	if(random(1) < damageAOEDropOff) {
		targetId.acidic = max(targetId.acidic, 240 + 240 * damageAOEDropOff);
	}
}