draw_set_alpha(.1);
draw_ellipse_colour(x - 160, y - 60, x + 160, y + 60, c_gray, c_gray, false);
draw_set_alpha(1);

draw_sprite_ext(sprite_index, image_index, x, y - height, image_xscale, image_yscale, image_angle, image_blend, image_alpha);