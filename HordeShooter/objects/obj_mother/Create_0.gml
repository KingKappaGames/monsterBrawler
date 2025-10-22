Health = 30;

xChange = 0;
yChange = 0;

dashCooldown = 180;

if(irandom(8) == 0) {
	Health *= 14;
	sprite_index = spr_rager;
}

if(irandom(1) == 1) {
	x = choose(0, room_width);
	y = irandom(room_height);
} else {
	x = irandom(room_width);
	y = choose(0, room_height);
}