if (live_call()) return live_result;

event_inherited();

audio_play_sound(snd_acidSplash, 0, 0);

damage = 2;
knockback = .8;
knockbackHeight = 0;
stun = 10;

durationMax = 18;

speed = 20;

hitRadius = 60;
hitSingle = false;
hitStopOn = false;

hitEnemy = function(hitId) {
	hitId.burning = max(300, hitId.burning);
	hitId.takeDamage(damage, direction, knockback, knockbackHeight, stun);
}

hit = function() {

}

global.partRush = part_type_create();
var _rushPart = global.partRush;
part_type_life(_rushPart, 60, 72);
part_type_shape(_rushPart, pt_shape_square);
part_type_size(_rushPart, .9, 1.3, -.035, 0);
part_type_orientation(_rushPart, 0, 360, 0, 0, false);
part_type_gravity(_rushPart, .04, 270);
part_type_blend(_rushPart, true);