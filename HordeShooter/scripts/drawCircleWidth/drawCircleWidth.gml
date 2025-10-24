function drawCircleWidth(xCenter, yCenter, outerRadius, innerRadius, segments = 12, color = c_white, outerAlpha = 1, innerAlpha = 1) {
	var jadd = 360/segments;
	
	var _middleRadius = (outerRadius + innerRadius) * .5;
	
	draw_set_color(color);
	draw_set_alpha(outerAlpha);
	draw_primitive_begin(pr_trianglestrip);
	for (var j = 0; j <= 360; j += jadd) {
	    draw_vertex(x + lengthdir_x(outerRadius, j), y + lengthdir_y(outerRadius, j) * .7);
	    draw_vertex(x + lengthdir_x(_middleRadius , j), y + lengthdir_y(_middleRadius, j) * .7);
	}
	draw_primitive_end();
	draw_set_alpha(innerAlpha);
	draw_primitive_begin(pr_trianglestrip);
	for (var j = 0; j <= 360; j += jadd) {
	    draw_vertex(x + lengthdir_x(innerRadius, j), y + lengthdir_y(innerRadius, j) * .7);
	    draw_vertex(x + lengthdir_x(_middleRadius, j), y + lengthdir_y(_middleRadius, j) * .7);
	}
	draw_primitive_end();
	draw_set_color(c_white);
	draw_set_alpha(1);
}