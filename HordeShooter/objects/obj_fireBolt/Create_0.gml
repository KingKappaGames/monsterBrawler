event_inherited();

damage = 8;
knockback = 9;
knockbackHeight = 3;
stun = 80;

durationMax = 70;

speed = 17;

hitSingle = false;

hitEnemy = function(hitId) {
	
}

hit = function() {
	audio_play_sound(snd_fireExplode, 0, 0);
	
	script_AOEDamageHit(,,, 270, damage, knockback,, knockbackHeight, stun,,, elementFunc);
	OWP_createPartExtColor(global.partFlamePuffs, x, y, 40, c_orange,, 90, 20, 1);
	part_type_speed(global.partStar, 2, 5, -.125, 0);
	OWP_createPartExtColor(global.partStar, x, y, 20, #ffe49c,, 20, 20, 5);
	part_type_speed(global.partOverwrittenTrailer, 3, 7, 0, 0);
	OWP_createPartExt(global.partOverwrittenTrailer, x, y, 20,, 0, 10, 1);
	
	instance_destroy();
}

elementFunc = function(damageAOEDropOff, targetId) {
	if(random(1) < damageAOEDropOff) {
		targetId.burning = max(targetId.burning, 200 + 200 * damageAOEDropOff);
	}
}