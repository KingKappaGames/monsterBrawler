if (live_call()) return live_result;



event_inherited();

part_type_direction(global.partRush, direction - 13, direction + 13, 0, 0);
part_type_speed(global.partRush, speed * .3, speed * .65, -.35, 0);
OWP_createPart(global.partRush, x, y, 10, choose(c_orange, c_red, c_yellow));
OWP_createPart(global.partFlamePuffs, x + hspeed * 4 + irandom_range(-30, 30), y + vspeed * 4 + irandom_range(-30, 30), 2, choose(c_orange, c_red, c_yellow), -y + 20);