x += xChange;
y += yChange;

yChange = yChange * .98 + .3;

if(irandom(15) == 0) {
	part_particles_create(global.sys, x, y, global.sparksParts, 1);
}

image_angle = point_direction(0, 0, xChange, yChange)

if(y > groundY) {
	hitEnemy();
}

if(x < -100 || x > room_width + 100) { instance_destroy(); }

if(y > room_height + 100) { instance_destroy(); }