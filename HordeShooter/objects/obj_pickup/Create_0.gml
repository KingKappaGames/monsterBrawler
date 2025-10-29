if (live_call()) return live_result;

sprite_index = spr_heart;

damage = -20;

range = 30;

pickUp = function(receiver) {
	receiver.takeDamage(damage, 0, 0, 0, 0);
	
	audio_play_sound(snd_Blap, 0, 0, 1, undefined, random_range(.8, 1.25));
	
	script_disintegrateObject(,, sprite_width * .5, sprite_height,,,, 0);
	
	script_createEffectWave(x, y, 15, 10, 41, .73, c_red, 7, -.28,,, -5000);
	
	part_type_speed(global.partRadialShimmer, 10, 19, -.9, 0); // do override this when you want though, should be set per effect in game
	OWP_createPart(global.partRadialShimmer, x, y, 12, c_red);
	
	instance_destroy();
}