event_inherited();

damage = 1;
stun = 5;
knockback = 2;
knockbackHeight = 0.25;

durationMax = 120;

speed = 12;

hitSingle = true;

part_particles_create(global.sys, x, y, global.sparksParts, 3);

//hitEnemy = function(hitId) {
	//
//}
//
hit = function() {
	part_particles_create(global.sys, x, y, global.sparksParts, 3);
	
	audio_play_sound(choose(snd_Blap, snd_blip, snd_click), 0, 0);
	
	instance_destroy();
}