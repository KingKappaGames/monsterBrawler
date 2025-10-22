draw_set_alpha(.4);
for(var i = array_length(linkedSmokes) - 1; i >= 0; i--) {
	draw_line_width_color(x, y, linkedSmokes[i].x, linkedSmokes[i].y, 40, c_dkgrey, c_grey)
}
draw_circle_color(x, y, 20, c_dkgrey, c_grey, false);
draw_set_alpha(1);