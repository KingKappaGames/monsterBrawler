var _cam = view_camera[0];
var _camX =	camera_get_view_x(_cam);
var _camY =	camera_get_view_y(_cam);
var _camW =	camera_get_view_width(_cam);
var _camH =	camera_get_view_height(_cam);

var _worldXLeft = floor((_camX - roomCreateBuffer) / biomeGridSize);
var _worldXRight = floor((_camX + _camW + roomCreateBuffer) / biomeGridSize);
var _worldYUp = floor((_camY - roomCreateBuffer) / biomeGridSize);
var _worldYDown = floor((_camY + _camH + roomCreateBuffer) / biomeGridSize);

var _worldHalfSize = worldSize div 2;

//draw rooms according to whether they're necessary, eg, always draw one, draw right if horizontals distinct, draw down if verticals distinct, and draw bottom right if both distinct, these all overlaid gives the option for 4 at most
draw_sprite(script_getBiomeBackground(worldDataGrid[_worldXLeft + _worldHalfSize][_worldYUp + _worldHalfSize][0]), 0, _worldXLeft * biomeGridSize, _worldYUp * biomeGridSize);
if(_worldXLeft != _worldXRight) { // horizontals distinct
	draw_sprite(script_getBiomeBackground(worldDataGrid[_worldXRight + _worldHalfSize][_worldYUp + _worldHalfSize][0]), 0, _worldXRight * biomeGridSize, _worldYUp * biomeGridSize);
}
if(_worldYUp != _worldYDown) { // verticals distinct
	draw_sprite(script_getBiomeBackground(worldDataGrid[_worldXLeft + _worldHalfSize][_worldYDown + _worldHalfSize][0]), 0, _worldXLeft * biomeGridSize, _worldYDown * biomeGridSize);
}
if(_worldXLeft != _worldXRight && _worldYUp != _worldYDown) { // both distinct
	draw_sprite(script_getBiomeBackground(worldDataGrid[_worldXRight + _worldHalfSize][_worldYDown + _worldHalfSize][0]), 0, _worldXRight * biomeGridSize, _worldYDown * biomeGridSize);
}