var _dirMove = point_direction(x, y, obj_shooter.x, obj_shooter.y);

xChange += dcos(_dirMove) * .05;
yChange -= dsin(_dirMove) * .05;

xChange *= .8;
yChange *= .8;

x += xChange;
y += yChange;

if(sprite_index == spr_rager) {
	image_angle += 18;
}

dashCooldown--;
if(dashCooldown == 0) {
	dashCooldown = irandom_range(120, 180);
	var _dir = irandom(360);
	var _mag = random_range(6, 10);
	
	xChange += dcos(_dir) * _mag;
	yChange += dsin(_dir) * _mag;
}