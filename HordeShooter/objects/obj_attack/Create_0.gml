allegiance = 0;
source = noone;

durationMax = 0;
duration = 0;

damage = 0;
stun = 0;
knockback = 0;
knockbackHeight = 0;

height = 0; // height affects draw and hitting (don't hit things not aligned with your height..)
heightHitRange = 20;

hitIds = []; // not used in most cases (IS used by melee and other overlapping attack things that need to only hit something once despite sending out damage all the time)

hitFunc = undefined; // passed to hit scripts for extra info

spawn = function() {
	
}