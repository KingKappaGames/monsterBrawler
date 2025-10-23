SM.step();

slowdown();

if(x < 0) {
	x = 2;
} else if(x > room_width * 2) {
	x = room_width * 2 - 2;
}

if(y < 0) {
	y = 2;
} else if(y > room_height * 2) {
	y = room_height * 2 - 2;
}

heightChange = min(10, heightChange); // keep it from doing absurd things..
height = min(500, height);

depth = -y - height;

//
//dashCooldown--;
//if(dashCooldown == 0) {
	//dashCooldown = irandom_range(60, 120);
	//
	//var _dir = irandom(360);
	//var _mag = random_range(1, 4);
	//
	//hspeed += lengthdir_x(_mag, _dir);
	//vspeed += lengthdir_y(_mag, _dir);
//}