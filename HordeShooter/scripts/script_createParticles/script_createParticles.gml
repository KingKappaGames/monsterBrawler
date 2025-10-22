function script_createParticles(xx, yy, part, quantity, color = undefined) {
	if(is_undefined(color)) {
		part_particles_create(global.sys, xx, yy, part, quantity);
	} else {
		part_particles_create_color(global.sys, xx, yy, part, color, quantity);
	}
}