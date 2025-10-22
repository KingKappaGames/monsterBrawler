draw_set_alpha(image_alpha);
draw_rectangle(x - radius - dcos(sinPos) * 8, y, x + radius + dcos(sinPos) * 8, y - 1000, false);
draw_set_alpha(.12 + dcos(sinPos) * .05);
draw_circle(x, y, 300, false);
draw_set_alpha(1);