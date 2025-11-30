if (live_call()) return live_result;

event_inherited();

camera_set_view_pos(view_camera[0], x - camera_get_view_width(view_camera[0]) * .5, y - camera_get_view_height(view_camera[0]) * .5);

spread *= spreadDecay;
recoil *= 1 - (1 - spreadDecay) * 5;
if(spread < spreadMinimum) {
	spread = spreadMinimum;
}

if(keyboard_check_pressed(vk_enter)) {
	script_spawnCreature(choose(obj_barbarian, obj_knight), 1 + irandom(10), mouse_x, mouse_y);
}

if(keyboard_check_pressed(vk_f7)) {
	script_spawnCreature(obj_darkPriest, 1 + irandom(10), mouse_x, mouse_y);
}
if(keyboard_check_pressed(vk_f8)) {
	script_spawnCreature(obj_priest, 1 + irandom(10), mouse_x, mouse_y);
}