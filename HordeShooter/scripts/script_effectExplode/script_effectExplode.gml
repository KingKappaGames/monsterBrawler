function script_effectExplode() {
	audio_play_sound(snd_explosion, 0, 0, random_range(.8, 1.2), undefined, random_range(.7, 1.4));
		
	script_createShockwaveSpell(x, y, 3, tileSize * 1.3, 1.26,, 1);
	
	part_particles_create_color(sys, x, y, explosionPart, merge_color(image_blend, c_white, .5), 25); // EXPLOSIVE PARTS
	part_type_speed(trailerPart, 2, 5, 0, 0);
	part_particles_create(sys, x, y, trailerPart, irandom_range(3, 4)); // TRAILINGS
	part_type_speed(starPart, 2.1, 4, -.07, 0);
	part_particles_create_color(sys, x, y, starPart, c_white, irandom_range(7, 10)); // STARS
}