Health = 4;

xChange = 0;
yChange = 0;

dashCooldown = 60;

if(irandom(1) == 1) {
	x = choose(0, room_width);
	y = irandom(room_height);
} else {
	x = irandom(room_width);
	y = choose(0, room_height);
}