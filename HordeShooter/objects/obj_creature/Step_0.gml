SM.step();

slowdown();

hitFlash--;

if(burning > 0) {
	if(irandom(5) == 0) {
		OWP_createPart(global.partFlamePuffs, x + irandom_range(-sprite_width * .4, sprite_width * .4), y - height - sprite_height * .6 + irandom_range(-sprite_height * .4, sprite_height * .4), 1, c_orange, -y - 30);
		
		if(irandom(4) == 0) {
			takeDamage(1, 0, 0, 0, 0,, false);
		}
	}
	
	burning--;
}

if(acidic > 0) {
	OWP_createPart(global.partThickTrail, x + irandom_range(-sprite_width * .4, sprite_width * .4), y - height - sprite_height * .4 + irandom_range(-sprite_height * .4, sprite_height * .4), 1, c_green, -y - 30);
	
	if(irandom(20) == 0) {
		takeDamage(1, 0, 0, 0, 0,, false);
	}
	
	acidic--;
}

if(poise < poiseMax) {
	poise++;
}

heightChange = min(10, heightChange); // keep it from doing absurd things..
height = min(500, height);

depth = -(y + 24) - height;

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