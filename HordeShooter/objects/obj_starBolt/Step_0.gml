event_inherited();

image_angle += spinSpeed;

part_type_orientation(global.basicSmoothTrail, direction, direction, 0, 0, 0);

OWP_createPart(global.basicSmoothTrail, x - hspeed, y - vspeed, 1, #ffff99);

part_type_speed(global.partStarMini, 0, 1.8, -.125, 0);

OWP_createPart(global.partStarMini, x + irandom_range(-3, 3), y + irandom_range(-3, 3), 1, choose(c_white, #ffff99, c_yellow));
