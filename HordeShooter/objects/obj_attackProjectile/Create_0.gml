event_inherited();

hitList = ds_list_create();

hitRadius = 3;
hitSingle = true;
hitStopOn = true; // whether to destroy the projectile when hitting something

homingDuration = 0;
homingTargetId = noone;
homingStrengthMult = 1;
homingRange = 500;

hitEnemy = function(hitId) {
	hitId.takeDamage(damage, direction, knockback, knockbackHeight, stun);
}

hit = function() {
	instance_destroy();
}