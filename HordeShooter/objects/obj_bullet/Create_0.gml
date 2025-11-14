event_inherited();

damage = 3;
stun = 5;
knockback = 1;
knockbackHeight = 0.25;

durationMax = 65;

speed = 17;

hitSingle = true;

heightHitRange = 20;

part_particles_create(global.sys, x, y, global.sparksParts, 3);

//hitEnemy = function(hitId) {
	//
//}
//
hit = function() {
	part_particles_create(global.sys, x, y, global.sparksParts, 3);
	
	audio_play_sound(choose(snd_blip, snd_click), 0, 0, 1, undefined, random_range(.7, 1.4));
	
	instance_destroy();
}

spawn = function() {
	image_angle = direction;
}