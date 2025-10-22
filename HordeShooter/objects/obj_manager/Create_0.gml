global.manager = id;

#macro grav .14

autoSpawn = false;

global.showDebug = false;

#region allegiances

enum E_allegiance {
	player = 0, 
	barbarian = 1,
	knight = 2, 
	/*, //3
	reachesApostle, 
	mortalist // 5*/
}

#macro allegianceCount 3

global.allegianceGrid = ds_grid_create(allegianceCount, allegianceCount); // each faction x each faction, gives the result of each combination
var _grid = global.allegianceGrid;

for(var _x = 0; _x < allegianceCount; _x++) {
	for(var _y = 0; _y < allegianceCount; _y++) {
		_grid[# _x, _y] = -1; // unset fill in value
	}
}

ds_grid_set(_grid, E_allegiance.player, E_allegiance.barbarian, 0);
ds_grid_set(_grid, E_allegiance.player, E_allegiance.knight, 1);
ds_grid_set(_grid, E_allegiance.barbarian, E_allegiance.knight, 0);

var _filledPositions = [];
var _filledCount = 0;
var _fillValue;
for(var _x = 0; _x < allegianceCount; _x++) {
	for(var _y = 0; _y < allegianceCount; _y++) {
		_fillValue = _grid[# _x, _y];
		if(_fillValue != -1) {
			_filledPositions[_filledCount] = [_x, _y, _fillValue];
			_filledCount++;
		}
	}
}

var _fillData;
for(var _mirrorI = 0; _mirrorI < _filledCount; _mirrorI++) {
	_fillData = _filledPositions[_mirrorI];
	_grid[# allegianceCount - 1 - _fillData[0], allegianceCount - 1 - _fillData[1]] = _fillData[2]; // flip filled values to mirror (eg barbarians hate knight SO knights hate barbarians, 1,3 = 3,1)
}

for(var _sameToSameI = 0; _sameToSameI < allegianceCount; _sameToSameI++) {
	_grid[# _sameToSameI, _sameToSameI] = 1; // reflexive views should always be positive, aka, no in fighting... Although... I suppose a type of person that fights others of its kind is possible.. for now nah though
}

#endregion


global.sys = part_system_create();
part_system_depth(global.sys, -500);

global.sparksParts = part_type_create();
part_type_size(global.sparksParts, .1, .2, 0, 0);
part_type_alpha2(global.sparksParts, 1, .1);
part_type_shape(global.sparksParts, pt_shape_square);
part_type_direction(global.sparksParts, 0, 360, 0, 0);
part_type_speed(global.sparksParts, .1, .5, 0, 0);
part_type_life(global.sparksParts, 30, 90);

global.sparksPartsWide = part_type_create();
part_type_size(global.sparksPartsWide, .1, .15, 0, 0);
part_type_alpha2(global.sparksPartsWide, 1, 0);
part_type_shape(global.sparksPartsWide, pt_shape_square);
part_type_direction(global.sparksPartsWide, 0, 360, 0, 0);
part_type_speed(global.sparksPartsWide, .3, 8, 0, 0);
part_type_life(global.sparksPartsWide, 17, 35);

global.sparksPartsThin = part_type_create();
part_type_size(global.sparksPartsThin, .07, .07, -.0001, 0);
part_type_alpha2(global.sparksPartsThin, .8, 0);
part_type_shape(global.sparksPartsThin, pt_shape_square);
part_type_orientation(global.sparksPartsThin, 0, 360, 0, 0, 0);
part_type_life(global.sparksPartsThin, 25, 30);

global.sparksPartsMortarSmall = part_type_create();
part_type_size(global.sparksPartsMortarSmall, .05, .3, -.001, 0);
part_type_alpha2(global.sparksPartsMortarSmall, 1, 0);
part_type_shape(global.sparksPartsMortarSmall, pt_shape_line);
part_type_direction(global.sparksPartsMortarSmall, 20, 160, 0, 0);
part_type_orientation(global.sparksPartsMortarSmall, 0, 0, 0, 0, 1);
part_type_speed(global.sparksPartsMortarSmall, .3, 5, 0, 0);
part_type_life(global.sparksPartsMortarSmall, 21, 120);
part_type_gravity(global.sparksPartsMortarSmall, .015, 270);

global.partDust = part_type_create();
var _dust = global.partDust;
part_type_sprite(_dust, spr_halfCircle64, 0, 0, 0);
part_type_size(_dust, .4, .9, -.002, 0);
part_type_alpha2(_dust, 1, 0);
part_type_direction(_dust, 0, 360, 0, 0);
part_type_speed(_dust, .2, 1, -.01, 0);
part_type_life(_dust, 45, 100);