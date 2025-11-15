sprite_index = spr_swordTemplate;

image_angle = 270;

range = 30;

itemInfo = -1;

pickupDelay = 45;

duration = 600;

pickUp = function(receiver) { 
	script_equipItem(itemInfo, receiver);
	
	audio_play_sound(snd_Blap, 0, 0, 1, undefined, random_range(.8, 1.25));
	
	script_createEffectWave(x, y, 15, 10, 41, .73, c_red, 7, -.28,,, -5000);
	
	part_type_speed(global.partRadialShimmer, 10, 19, -.9, 0); // do override this when you want though, should be set per effect in game
	OWP_createPart(global.partRadialShimmer, x, y, 12, c_red);
	
	instance_destroy();
}