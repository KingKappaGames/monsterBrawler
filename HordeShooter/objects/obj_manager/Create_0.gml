randomize();

audio_master_gain(.8); // why is it so loud

global.manager = id;

#macro grav .18

autoSpawn = false;

global.showDebug = false;

global.cameraScale = .5;
#macro camWidthBase 1920
#macro camHeightBase 1080

#region allegiances

#macro allegianceCount 3

enum E_allegiance {
	player = 0, 
	barbarian = 1,
	knight = 2, 
}

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

#region gmRoomLoader stuff

#macro roomSize 1800
#macro roomCreateBuffer 50
#macro roomDestroyBuffer 80

RoomLoader.DataInit(rm_mapPlaza);
RoomLoader.DataInit(rm_mapField);
RoomLoader.DataInit(rm_mapForest);

roomGrid = array_create(50);
for(var _i = 0; _i < 50; _i++) {
	roomGrid[_i] = array_create(50, 0);
}

function updateRooms() {
	var _cam = view_camera[0];
	var _camX = camera_get_view_x(_cam) + roomSize * 1000;
	var _camY = camera_get_view_y(_cam) + roomSize * 1000;
	var _camW = camera_get_view_width(_cam);
	var _camH = camera_get_view_height(_cam);
	var _camRight = _camX + _camW;
	var _camBottom = _camY + _camH;
	
	//if(roomGrid[_roomX][_roomY] == 0) { // in theory the center room should never loaded (except when tp'ing maybe?)
		//roomGrid[_roomX][_roomY] = RoomLoader.Load(rm_mapField, (_roomX - 25) * roomSize, (_roomY - 25) * roomSize);
	//}
	
	var _roomX, _roomY, _roomPrevX, _roomPrevY, _hold;
	
	_roomX = 25 + (_camX - roomCreateBuffer) div roomSize - 1000; // top left
	_roomY = 25 + (_camY - roomCreateBuffer) div roomSize - 1000;
	if(roomGrid[_roomX][_roomY] == 0) {
		roomGrid[_roomX][_roomY] = RoomLoader.Load(choose(rm_mapField, rm_mapForest, rm_mapPlaza), (_roomX - 25) * roomSize, (_roomY - 25) * roomSize);
	}
	_roomPrevX = 25 + (_camX - roomDestroyBuffer) div roomSize - 1000;
	_roomPrevY = 25 + (_camY - roomDestroyBuffer) div roomSize - 1000;
	if(_roomPrevX != _roomX || _roomPrevY != _roomY) { // targeting "lone" tile without creation insentive, aka not in range of creator but in range of destroyer, destroyer will always be opposed by the presence of creator here, the tiles are too big to overlap in any other way. Poetic.
		if(roomGrid[_roomPrevX][_roomPrevY] != 0) {
			roomGrid[_roomPrevX][_roomPrevY].Cleanup();
			roomGrid[_roomPrevX][_roomPrevY] = 0;
		}
	}
	
	
	_roomX = 25 + (_camX + _camW + roomCreateBuffer) div roomSize - 1000; // top right
	_roomY = 25 + (_camY - roomCreateBuffer) div roomSize - 1000;
	if(roomGrid[_roomX][_roomY] == 0) {
		roomGrid[_roomX][_roomY] = RoomLoader.Load(rm_mapField, (_roomX - 25) * roomSize, (_roomY - 25) * roomSize);
	}
	_roomPrevX = 25 + (_camX + _camW + roomDestroyBuffer) div roomSize - 1000;
	_roomPrevY = 25 + (_camY - roomDestroyBuffer) div roomSize - 1000;
	if(_roomPrevX != _roomX || _roomPrevY != _roomY) {
		if(roomGrid[_roomPrevX][_roomPrevY] != 0) {
			roomGrid[_roomPrevX][_roomPrevY].Cleanup();
			roomGrid[_roomPrevX][_roomPrevY] = 0;
		}
	}
	
	_roomX = 25 + (_camX + _camW + roomCreateBuffer) div roomSize - 1000; // bottom right
	_roomY = 25 + (_camY + _camH + roomCreateBuffer) div roomSize - 1000;
	if(roomGrid[_roomX][_roomY] == 0) {
		roomGrid[_roomX][_roomY] = RoomLoader.Load(rm_mapField, (_roomX - 25) * roomSize, (_roomY - 25) * roomSize);
	}
	_roomPrevX = 25 + (_camX + _camW + roomDestroyBuffer) div roomSize - 1000;
	_roomPrevY = 25 + (_camY + _camH + roomDestroyBuffer) div roomSize - 1000;
	if(_roomPrevX != _roomX || _roomPrevY != _roomY) {
		if(roomGrid[_roomPrevX][_roomPrevY] != 0) {
			roomGrid[_roomPrevX][_roomPrevY].Cleanup();
			roomGrid[_roomPrevX][_roomPrevY] = 0;
		}
	}
	
	_roomX = 25 + (_camX - roomCreateBuffer) div roomSize - 1000; // bottom left
	_roomY = 25 + (_camY + _camH + roomCreateBuffer) div roomSize - 1000;
	if(roomGrid[_roomX][_roomY] == 0) {
		roomGrid[_roomX][_roomY] = RoomLoader.Load(rm_mapField, (_roomX - 25) * roomSize, (_roomY - 25) * roomSize);
	}
	_roomPrevX = 25 + (_camX - roomDestroyBuffer) div roomSize - 1000;
	_roomPrevY = 25 + (_camY + _camH + roomDestroyBuffer) div roomSize - 1000;
	if(_roomPrevX != _roomX || _roomPrevY != _roomY) {
		if(roomGrid[_roomPrevX][_roomPrevY] != 0) {
			roomGrid[_roomPrevX][_roomPrevY].Cleanup();
			roomGrid[_roomPrevX][_roomPrevY] = 0;
		}
	}
}
#endregion

#region particle stuff

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
part_type_sprite(_dust, spr_halfCloud, 0, 0, 0);
part_type_size(_dust, .5, 1.1, 0, 0);
part_type_alpha2(_dust, 1, 0);
part_type_direction(_dust, 0, 360, 0, 0);
part_type_speed(_dust, .2, 1, -.01, 0);
part_type_life(_dust, 45, 100);

global.partBreak = part_type_create();
var _break = global.partBreak;
part_type_life(_break, 27, 45);
part_type_shape(_break, pt_shape_square);
part_type_size(_break, .4, .6, -.012, 0);
part_type_alpha2(_break, 1, 0);
part_type_speed(_break, .25, 1.05, 0, 0);
part_type_direction(_break, 0, 360, 0, 0);
part_type_orientation(_break, 0, 360, 3, 5, false);
part_type_gravity(_break, .032, 270);

global.partExplosion = part_type_create();
var _explosionPart = global.partExplosion;
part_type_life(_explosionPart, 20, 42);
part_type_shape(_explosionPart, pt_shape_square);
part_type_size(_explosionPart, .6, .9, -.015, 0);
part_type_size_x(_explosionPart, .3, .3, 0, 0);
part_type_alpha2(_explosionPart, 1, 0);
part_type_speed(_explosionPart, 1.6, 4.8, -.18, 0);
part_type_direction(_explosionPart, 0, 360, 0, 0);
part_type_orientation(_explosionPart, 0, 360, 3, 5, false);

global.partStar = part_type_create();
var _star = global.partStar;
part_type_life(_star, 150, 180);
part_type_sprite(_star, spr_starShape, false, false, false);
part_type_size(_star, .5, 1.5, -.013, 0); // limiting factor hopefully
part_type_speed(_star, 1.6, 4.8, -.18, 0); // do override this when you want though, should be set per effect in game
part_type_direction(_star, 0, 360, 0, 0);
part_type_orientation(_star, 0, 360, 3, 5, false);

global.partStarMini = part_type_create();
var _starMini = global.partStarMini;
part_type_life(_starMini, 120, 120);
part_type_sprite(_starMini, spr_starShape, false, false, false);
part_type_size(_starMini, .5, .8, -.015, 0); // limiting factor hopefully
part_type_speed(_starMini, 1.6, 4.8, -.18, 0); // do override this when you want though, should be set per effect in game
part_type_direction(_starMini, 0, 360, 0, 0);
part_type_orientation(_starMini, 0, 360, 3, 5, false);

global.partRadialShimmer = part_type_create();
var _radialShimmer = global.partRadialShimmer;
part_type_life(_radialShimmer, 60, 60);
part_type_sprite(_radialShimmer, spr_roundBeamShape, false, false, false);
part_type_size(_radialShimmer, 1, 1.4, -.047, 0); // limiting factor hopefully
part_type_speed(_radialShimmer, 2.7, 4.3, -.035, 0); // do override this when you want though, should be set per effect in game
part_type_direction(_radialShimmer, 0, 360, 0, 0);
part_type_orientation(_radialShimmer, 0, 0, 0, 0, true);

global.partRoundTrail = part_type_create();
var _roundTrail = global.partRoundTrail;
part_type_life(_roundTrail, 40, 40);
part_type_shape(_roundTrail, pt_shape_square);
part_type_size(_roundTrail, .07, .09, -.004, 0);
part_type_alpha2(_roundTrail, 1, .3);
part_type_speed(_roundTrail, 0, .4, -.004, 0);
part_type_direction(_roundTrail, 0, 360, 0, 0);
part_type_orientation(_roundTrail, 0, 0, 1.7, 0, 0);
part_type_color1(_roundTrail, #ffffff)

global.partOverwrittenTrailer = part_type_create(); // no visuals?
var _trailerPart = global.partOverwrittenTrailer;
part_type_life(_trailerPart, 25, 90);
part_type_direction(_trailerPart, 0, 180, 0, 0); // over write speed per particle use case in code, no default
part_type_gravity(_trailerPart, .11, 270);
part_type_step(_trailerPart, -2, _roundTrail);

global.partSmokeTrail = part_type_create();
var _smokeTrail = global.partSmokeTrail;
part_type_life(_smokeTrail, 75, 110);
part_type_shape(_smokeTrail, pt_shape_square);
part_type_size(_smokeTrail, .14, .14, .007, 0);
part_type_alpha2(_smokeTrail, 1, 0);
part_type_speed(_smokeTrail, 0.15, .3, -.008, 0);
part_type_direction(_smokeTrail, 0, 360, 0, 0);
part_type_gravity(_smokeTrail, -.03, 270);

global.partThickTrail = part_type_create();
var _thickTrail = global.partThickTrail;
part_type_life(_thickTrail, 50, 70);
part_type_shape(_thickTrail, pt_shape_square);
part_type_size(_thickTrail, .2, .3, -.007, 0);
part_type_speed(_thickTrail, 0.0, .2, -.002, 0);
part_type_direction(_thickTrail, 0, 360, 0, 0);
part_type_orientation(_thickTrail, 0, 360, 0, 0, false);
part_type_gravity(_thickTrail, -.03, 270);

global.partFlamePuffs = part_type_create();
var _firePuff = global.partFlamePuffs;
part_type_life(_firePuff, 40, 40);
part_type_sprite(_firePuff, spr_flamePuff, 1, 1, 0);
part_type_size(_firePuff, 3, 4, -.1, 0);
part_type_speed(_firePuff, 0, .3, -.05, 0);
part_type_direction(_firePuff, 0, 180, 0, 0);
part_type_gravity(_firePuff, .14, 90);

global.partSnowTrail = part_type_create();
var _snowTrail = global.partSnowTrail;
part_type_life(_snowTrail, 100, 100);
part_type_sprite(_snowTrail, spr_snowFlake16, 0, 0, 0);
part_type_size(_snowTrail, 1.5, 2.5, -.02, 0);
part_type_speed(_snowTrail, 0.2, .3, 0, 0);
part_type_direction(_snowTrail, 0, 360, 0, 20);
part_type_orientation(_snowTrail, 0, 360, 0, 0, false);
part_type_alpha2(_snowTrail, 1, 0);

global.partTrailChunk = part_type_create();
var _chunkTrail = global.partTrailChunk;
part_type_life(_chunkTrail, 80, 80);
part_type_sprite(_chunkTrail, spr_chunk8, 0, 0, 0);
part_type_size(_chunkTrail, 2.7, 3.3, -.042, 0);
part_type_speed(_chunkTrail, 0.24, .5, -.005, 0);
part_type_direction(_chunkTrail, 0, 360, 0, 20);
part_type_orientation(_chunkTrail, 0, 360, 0, 0, false);

global.partThickHaze = part_type_create();
var _thickHaze = global.partThickHaze;
part_type_life(_thickHaze, 90, 140);
part_type_sprite(_thickHaze, spr_halfCloud, 0, 0, 0);
part_type_size(_thickHaze, 0, .3, .017, 0);
part_type_speed(_thickHaze, 0.0, .2, -.002, 0);
part_type_direction(_thickHaze, 0, 360, 0, 0);
part_type_alpha2(_thickHaze, 1, 0);

global.partBloodSpurt = part_type_create();
var _bloodSpurt = global.partBloodSpurt;
part_type_life(_bloodSpurt, 35, 70);
part_type_shape(_bloodSpurt, pt_shape_disk);
part_type_size(_bloodSpurt, .1, .3, -.008, 0);
part_type_speed(_bloodSpurt, 1.5, 2.7, -.003, 0);
part_type_gravity(_bloodSpurt, .02, 270);

global.partRush = part_type_create();
var _rushPart = global.partRush;
part_type_life(_rushPart, 120, 120);
part_type_shape(_rushPart, pt_shape_square);
part_type_size(_rushPart, .8, .9, -.007, 0);
part_type_orientation(_rushPart, 0, 360, 0, 0, false);
part_type_gravity(_rushPart, .04, 270);
part_type_blend(_rushPart, false);

global.partItemGlimmer = part_type_create();
var _itemGlimmer = global.partItemGlimmer;
part_type_life(_itemGlimmer, 90, 300);
part_type_shape(_itemGlimmer, pt_shape_square);
part_type_size(_itemGlimmer, .6, .9, -.004, 0);
part_type_speed(_itemGlimmer, 0.2, .4, -.001, 0);
part_type_direction(_itemGlimmer, 0, 360, 0, 0);
part_type_gravity(_itemGlimmer, -.003, 270);

#endregion

//repeat(250) {
	//instance_create_depth(irandom_range(-500, room_width * 2 + 500), irandom_range(-500, room_height * 2 + 500), 0, obj_visual);
//}