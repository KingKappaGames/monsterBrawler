gravityChange = -.001;
xChange = -.5 + random(1);
yChange = -.5 + random(1);

smokeAmount = 32;

linkedSmokes[0] = id;

joinSmokes = function() {
	while(smokeAmount >= 1) {
		var _smoke = instance_create_layer(x, y, "Instances", obj_smokeCloud);
		linkedSmokes[array_length(linkedSmokes)] = _smoke;
		_smoke.smokeAmount = smokeAmount / 2;
		smokeAmount /= 2;
		_smoke.joinSmokes();
	}
}