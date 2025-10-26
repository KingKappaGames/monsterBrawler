image_yscale = 0;
image_xscale = 0;
image_angle = 0;

getCollisions = function(startX, startY, width, height, angle, targets, ordered) {
	x = startX;
	y = startY;
	image_xscale = height / 20;
	image_yscale = width / 20;
	image_angle = angle;
	
	var _collisionList = ds_list_create(); // create new list I guess? Before it was rerefing and breaking the list so i guess don't do that, but what did I do?
	
	var _count = instance_place_list(x, y, targets, _collisionList, ordered);
	
	return _collisionList; // my god it's so simple, sure, some of this didn't exist but man I made things hard back then
}