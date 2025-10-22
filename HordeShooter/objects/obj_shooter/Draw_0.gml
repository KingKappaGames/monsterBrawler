draw_circle(x, y, 10, true);
var _xPull = dcos(directionAiming);
var _yPull = dsin(directionAiming);
draw_line_width(x + _xPull * -recoil + irandom_range(-sqrt(recoil), sqrt(recoil)), y + _yPull * recoil + irandom_range(-sqrt(recoil), sqrt(recoil)), x + _xPull * (16 - recoil) + irandom_range(-sqrt(recoil), sqrt(recoil)), y - _yPull * (16 - recoil) + irandom_range(-sqrt(recoil), sqrt(recoil)), 5);