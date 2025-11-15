event_inherited();

if(duration == round(durationMax) * .5) {
	if(instance_exists(target)) {
		target.takeDamage(damage, 0, knockback, knockbackHeight, stun);
		x = target.x;
		y = target.y;
	} else {
		target = noone;
		duration *= .5;
	}
}