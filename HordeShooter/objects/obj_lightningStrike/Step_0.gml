event_inherited();

if(global.timer % 10 == 0) {
	if(instance_exists(target)) {
		target.takeDamage(damage, 0, knockback, knockbackHeight, stun);
		x = target.x;
		y = target.y;
	} else {
		target = noone;
		duration *= .5;
	}
}