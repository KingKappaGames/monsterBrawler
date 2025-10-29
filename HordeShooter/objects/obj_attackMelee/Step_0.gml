timer++;

if(timer % 3 == 0) {
	hitIds = array_concat(hitIds, script_MeleeHitBoxRotated(allegiance, x, y, image_angle, thickness, length, height, heightHitRange, damage, knockback, image_angle, knockbackHeight, stun, hitFunc,, hitIds));
	if(!hasHitSomething) {
		if(array_length(hitIds) > 0) {
			hasHitSomething = true;
			
			audio_play_sound(choose(snd_smack, snd_smack2, snd_smack3), 0, 0, random_range(.5, 1), 0, random_range(.8, 1.25));
		}
	}
}

event_inherited();