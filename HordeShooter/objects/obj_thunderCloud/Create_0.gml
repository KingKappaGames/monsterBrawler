event_inherited();

durationMax = 600;
duration = 600;

damage = 10;
stun = 1000;
knockback = 0;
knockbackHeight = 0;

height = 170;
heightHitRange = 9999;

hitDurationMin = 0;

radius = 200;

sprite_index = spr_thunderCloud;

image_alpha = .8;

hitList = ds_list_create();

spawn = function() {
	script_setAnimation(sprite_index, 0, 1.5);
}

//hitFunc = function() {
	//
//}

depth = -y - 2500;