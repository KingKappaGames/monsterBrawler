draw_text_transformed_color(view_wport[0] - 100, 20, fps_real, 1, 1, 0, c_red, c_red, c_red, c_red, .7);

draw_text_transformed_color(view_wport[0] - 100, 40, instance_number(obj_visual), 1, 1, 0, c_red, c_red, c_red, c_red, .7);


//var _cam = view_camera[0];
//var _camX = camera_get_view_x(_cam);
//var _camY = camera_get_view_y(_cam);
//var _camW = camera_get_view_width(_cam);
//var _camH = camera_get_view_height(_cam);
//
//draw_circle_color(350 + (_camX - 100) / 160, 350 + (_camY - 100) / 160, 2, c_black, c_black, false);
//draw_circle_color(350 + (_camX - 100) / 160, 350 + (_camY + _camH + 100) / 160, 2, c_black, c_black, false);
//draw_circle_color(350 + (_camX + _camW + 100) / 160, 350 + (_camY - 100) / 160, 2, c_black, c_black, false);
//draw_circle_color(350 + (_camX + _camW + 100) / 160, 350 + (_camY + _camH + 100) / 160, 2, c_black, c_black, false);
//
//for(var _x = 0; _x < 50; _x++) {
	//for(var _y = 0; _y < 50; _y++) {
		//var _val = roomGrid[_x][_y] == 0;
		//var _col = _val ? c_white : c_red; 
		//draw_rectangle_color(101 + _x * 10, 101 + _y * 10, 109 + _x * 10, 109 + _y * 10, _col, _col, _col, _col, true);
	//}
//}