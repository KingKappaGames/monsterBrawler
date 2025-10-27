//if(live_call()) { return live_result }

event_inherited();

draw_set_color(image_blend);

draw_circle(x, y, 10, false);

if(pathMoving) {
	//draw_circle(x, y, 30 + irandom(10), true);
	//draw_path(pathCurrent, 0, 0, true);
	//draw_text(x, y + 20, $"path position: {path_position}");
	//draw_text(x, y + 32, path_get_name(pathCurrent));
	//draw_text(x, y + 44, $"pathCurrentLength: {pathCurrentLength}");
	
	//raw_text(x, y - 60, pathCurrentStartTime);
	
	//draw_circle(pathGoalX, pathGoalY, pathGoalRadius, true);
}

draw_set_color(c_white);

if(leader) {
	draw_sprite(spr_crown, 0, x, y - 10);
} else if(instance_exists(followingId)) {
	draw_sprite(spr_crown, 1, x, y - 10);
}

draw_text(x, y + 100, dialoguePartner);
draw_text(x, y + 120, inDialogue);
draw_text(x, y + 140, dialogueType);
draw_text(x, y + 160, text);