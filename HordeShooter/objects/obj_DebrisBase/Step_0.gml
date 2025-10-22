duration--;
image_angle += spinSpeed;

if(movementType != 0) {
	x += xChange;
	y -= yChange;
	airHeight += heightChange;
}
if(movementType == 1) {
	xChange *= speedDecay;
	yChange *= speedDecay;
} else if(movementType == 2) {
	if(airHeight > 0) {
		canExpire = 0;
		heightChange -= gravityStrength;
	} else {
		airHeight = 0;
		heightChange = abs(heightChange) * movementAdjust; // send it back towards the air
		
		duration -= 5; // decrease time on bounces to prevent turbo bouncing, 5 inst enough to matter for big bounces but frame bouncing should be culled
		spinSpeed = irandom_range(-9, 9);
		xChange *= speedDecay;
		yChange *= speedDecay;
		canExpire = 1;
	}
} else if(movementType == 3) {
	if(airHeight > 0) {
		heightChange -= gravityStrength;
		if(airHeight + heightChange < 0) {
			airHeight = 0;
			
			heightChange = 0;
			spinSpeed = xChange * 2// * ((1 / size) + .1);
			canExpire = 1;
		}
	} else {
		xChange *= speedDecay;
		yChange *= speedDecay;
		spinSpeed *= speedDecay;
		
	}
} else if(movementType == 4) {
	if(airHeight > 0) {
		heightChange -= gravityStrength;
	} else {
		airHeight = 0;
		duration = 0;
		canExpire = 1;
	}
}

if(duration < -180) {
	canExpire = 1;
}
if(duration < 1 && canExpire == 1) {
	instance_destroy();
}