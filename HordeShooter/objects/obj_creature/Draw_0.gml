//draw_circle(x, y, 10, true)
draw_ellipse_color(x - sprite_width * .3, y - 5, x + sprite_width * .3, y + 5, #111111, #111111, false); // shadow
draw_sprite_ext(sprite_index, image_index, x, y - height, directionFacing * image_xscale, image_yscale, image_angle, image_blend, image_alpha);

if(global.showDebug) {
	draw_line(x, y, x, y - Health * 3);
	draw_text_transformed(x, y - Health * 3 - 10, Health, .75, .75, 0);
	
	draw_text(x, y + 60, SM.get_current_state());
	draw_text(x, y + 80, stateTimer);
}

//SM.draw();