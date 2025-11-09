SM.step();

slowdown();

if(trailDuration > 0) {
	trailDuration--;
	
	OWP_createPart(trailPart, x + irandom_range(-6, 6), bbox_bottom + irandom_range(-6, 6) - height, 1, trailPartColor, -y);
}

hitFlash--;

if(burning > 0 || alwaysBurning) {
	if(irandom(5) == 0) {
		OWP_createPart(global.partFlamePuffs, x + irandom_range(-sprite_width * .32, sprite_width * .32), y - height - sprite_height * .42 + irandom_range(-sprite_height * .32, sprite_height * .32), 1, c_orange, -y - 30);
		
		if(!alwaysBurning && irandom(4) == 0) {
			takeDamage(1, 0, 0, 0, 0,, false);
		}
	}
	
	burning--;
}

if(acidic > 0) {
	OWP_createPart(global.partThickTrail, x + irandom_range(-sprite_width * .32, sprite_width * .32), y - height - sprite_height * .42 + irandom_range(-sprite_height * .32, sprite_height * .32), 1, c_green, -y - 30);
	
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