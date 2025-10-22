y -= .5;
x += dcos(sinPos) * 1.1;

sinPos += 1.5;

duration--;
image_alpha = duration / 120;

if(duration < 0) {
	instance_destroy();
}