event_inherited();

part_particles_create(global.sys, x, y, global.sparksPartsThin, 1);

var _hit = false;
with(obj_creature) {
	if(point_distance(x, y, other.x, other.y) < 20) {
		if(other.source != id) {
			if(script_judgeAllegiance(allegiance, other.allegiance) < .5) {
				takeDamage(other.damage, other.direction, other.knockback, other.knockbackHeight, other.stun); // Waiter, waiter! More accesor calls please!
				_hit = true;
				break;
			}
		}
	}
}

if(_hit) {
	part_particles_create(global.sys, x, y, global.sparksParts, 3);
	
	audio_play_sound(choose(snd_Blap, snd_blip, snd_click), 0, 0)
	
	instance_destroy();
}