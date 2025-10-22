if(duration > 0) {
	duration--;
	radius += increase;
	increase *= .88;
} else {
	instance_destroy();
}