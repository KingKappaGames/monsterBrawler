startRunX = 0;
startRunY = 0;
endRunX = 0;
endRunY = 0;

travelX = 0;
travelY = 0;
travelDir = 0;
travelDist = 0;

flightSpeed = 3;
xChange = 0;
yChange = 0;

bombCount = 10;
bombIndex = 0;

planeHeight = 400;

audio_play_sound(snd_rough, 0, 0);

getRoute = function() {
	travelX = startRunX - endRunX;
	travelY = startRunY - endRunY;
	travelDist = point_distance(travelX, travelY, 0, 0);
	travelDir = point_direction(0, 0, travelX, travelY);
	image_angle = travelDir;
	xChange = dcos(travelDir) * flightSpeed;
	yChange = dsin(travelDir) * flightSpeed;
	x = startRunX;
	y = startRunY;
	while(x < room_width + 50 && x > -50 && y < room_height + 50 && y > -50) {
		x += xChange * 20;
		y -= yChange * 20;
	}
}