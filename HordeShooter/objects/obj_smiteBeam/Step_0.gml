image_alpha += alphaChange;

if(image_alpha < 0) {
	instance_destroy();
} else if(image_alpha > 1) {
	alphaChange *= -1;
}

sinPos += 40;

if(irandom(20) == 0) {
	script_AOEDamageHit(,,, 250, 3, 1.2);
}