event_inherited();

durationMax = 600;
duration = 600;

damage = 6;
stun = 500;
knockback = 8;
knockbackHeight = 3.5;

height = 0;
heightHitRange = 9999;

hitDurationMin = 0;

radius = 140;

sprite_index = spr_dustTornado;

swirlList = ds_list_create();

spawn = function() {
	script_setAnimation(sprite_index, 0, 7);
}

//hitFunc = function() {
	//
//}