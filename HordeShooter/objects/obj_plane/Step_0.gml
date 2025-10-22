x -= xChange;
y += yChange;

if(x < -300 || x > room_width + 300) { instance_destroy(); }

if(y < -300 || y > room_height + 300) { instance_destroy(); }

if(bombIndex < bombCount) {
	if(point_distance(x, y, endRunX, endRunY) < travelDist / bombCount * (bombCount - bombIndex)) {
		var _mortar = instance_create_depth(x, y - planeHeight, 0, obj_mortar);
		_mortar.groundY = y;
		
		bombIndex++;
	}
}