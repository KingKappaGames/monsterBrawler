if(duration > 0) {
	duration--;
	radius += increaseFlat;
	radius *= increaseMult;
	width += widthChange;
} else {
	instance_destroy();
}