//draw_circle(x, y, 10, true)
//draw_ellipse_color(x - sprite_width * .3, y + 15, x + sprite_width * .3, y + 25, #111111, #111111, false); // shadow

if(hitFlash > 0) {
	shader_set(shd_hitFlash);
} else {
	shader_set(shd_brightness);
	if(alwaysBurning) {
		shader_set_uniform_f(shader_get_uniform(shd_brightness, "strength"), 0);
	} else {
		shader_set_uniform_f(shader_get_uniform(shd_brightness, "strength"), -min(.8, burning * .02));
	}
}

draw_sprite_ext(sprite_index, image_index, x, y - height, directionFacing * image_xscale, image_yscale, image_angle, image_blend, image_alpha);

shader_reset();

if(frozen) {
	draw_sprite_ext(spr_iceBlock, 0, x, y, sprite_width / 32, sprite_height / 32, 0, c_white, .9);
}

if(global.showDebug) {
	draw_line(x, y, x, y - Health * 3);
	draw_text_transformed(x, y - Health * 3 - 10, Health, .75, .75, 0);
	
	draw_text(x, y + 60, SM.get_current_state());
	draw_text(x, y + 80, stateTimer);
}

//SM.draw();