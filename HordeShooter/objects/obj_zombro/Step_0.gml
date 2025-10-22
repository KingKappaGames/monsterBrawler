var _dirMove = point_direction(x, y, obj_shooter.x, obj_shooter.y);

xChange += dcos(_dirMove) * .03;
yChange -= dsin(_dirMove) * .03;

xChange *= .97;
yChange *= .97;

x += xChange;
y += yChange;

dashCooldown--;
if(dashCooldown == 0) {
	dashCooldown = irandom_range(60, 120);
	var _dir = irandom(360);
	var _mag = random_range(1, 4);
	
	xChange += dcos(_dir) * _mag;
	yChange += dsin(_dir) * _mag;
}