global.OWPmanager = id;

#macro OWPshowDebug false // set this to true to enable debug display and middle click particles, false to have it compile out of the project, since it's a macro the debug code won't even be in the compiled game when it's false, no need to "clean it up" it's already literally no lag at all, aren't compilers neat

if(OWPshowDebug) {
	debugPart = part_type_create();
	part_type_size(debugPart, 40, 40, 0, 0);
	part_type_color1(debugPart, c_green);
	part_type_life(debugPart, 99999999, 99999999); // simple immortal non moving particle to compare depths with
}

sysCount = 1200; // count X spacing is the total screen range in room pixels that the sys manages, set this range to be your screen plus margins if particles ever move up or down within their system and would leave the locality of their layer (depth = -y) as a guess. Because their depths are popped up or down at the edges put those off screen by 10% or something
sysSpacing = 1;

sysUpdateRange = 200; // if the screen varies from the last update by this many pixels the systems will be updated (hence why the buffer space is important, among other things)

previousCamY = camera_get_view_y(view_camera[0]);
previousEdgeY = previousCamY - sysUpdateRange;

currentSysEdge = 0;

global.sysBottom = part_system_create(); // these two over/under layers can be removed if you want to do your own or whatever, they're not part of the whole moving depth system, just delete this and the pause/resume calls below and you're good
part_system_depth(global.sysBottom, 5000); // bottom, where ever that is V  (not part of the moving system! But often times you will want a particle layer that goes under everything)

global.sysTop = part_system_create();
part_system_depth(global.sysTop, -5000); // top, what ever depth that is ^ (not part of the moving system! But often times you will want a particle layer that goes over everything)

sysCollection = array_create(sysCount, 0);

var _sysSet = sysCollection;
var _depthOfInitial = -(camera_get_view_y(view_camera[0]) - sysUpdateRange);
var _sysAddI = 0;
repeat(sysCount) {
	_sysSet[_sysAddI] = part_system_create();
	part_system_depth(_sysSet[_sysAddI], _depthOfInitial - _sysAddI * sysSpacing); // down screen / positive y / less depth (negative)
	_sysAddI++;
}

///@param {REAL} borderWidth The height in pixels of the margins above and below the screen
///@param {REAL} systemSpacing The height of each layer in pixels, this being 1 means the layering DEPTH is pixel perfect, being 100 means your particles will snap to depths of 100 (the position is always correct regardless, this is a GM thing, the only thing this system does is depth, you don't need to mess with position at all)
///@param {REAL} forceSystemCount The quantity of systems to use (will update the collection to have this many systems)
///@param {REAL} camIndex The index number for the camera to calculate positions with (default 0)
setSpacing = function(borderWidth = 20, systemSpacing = 1, forceSystemCount = -1, camIndex = 0) {
	sysUpdateRange = borderWidth; // the margins above and below the screen (only really useful for preventing movement from showing off the screen (which isn't even a problem BUT the particles created when doing so will be dropped to the nearest depth.. And you'll notice that when you go far enough to see them in a position they shouldn't be (clumped on the edge vs placed along the range they were intended to have))
	sysSpacing = systemSpacing;
	
	var _systemCount = 0;
	if(forceSystemCount == -1) {
		_systemCount = ceil((camera_get_view_height(view_camera[camIndex]) + borderWidth * 2) / sysSpacing); // default to placing enough layers to cover camera and margins with spaced layers, though I guess there's some use for doing a different set up?
	} else {
		_systemCount = forceSystemCount; // if forced, set forced count
	}
	
	var _oldSysCount = sysCount;
	sysCount = _systemCount;
	
	#region // resize the layer collection to match new count
	
	if(sysCount > _oldSysCount) {
		array_resize(sysCollection, sysCount);
		for(var _i = _oldSysCount; _i < sysCount; _i++) {
			sysCollection[_i] = part_system_create();
		}
	} else if(sysCount < _oldSysCount) {
		for(var _i = sysCount; _i < _oldSysCount; _i++) {
			part_system_destroy(sysCollection[_i]);
		}
		array_resize(sysCollection, sysCount);
	}
	#endregion
	
	setCollectionPosition(); // pass values here to maintain use camera and force position values I guess (I aint doing that tho)
}

///@desc This replaces all the systems to the desired position and updates their depths to be current with this new position, this can be useful for immediate jumps or changes (like spawning in, since there's no reference point on the first frame). Note though that the system already does this when moving more than a full system at once so teleports and such changes should be handled automatically, but this is here if you need it.
///@param {REAL} forcePosition This passes in a position instead of the camera, if for some reason you want to arrange the collection around y = 1000 when the camera is somewhere else
setCollectionPosition = function(forcePosition = undefined) {
	var _holdCamY = previousCamY;
	var _holdEdge = currentSysEdge;
	
	previousCamY = (camera_get_view_y(view_camera[0]) div sysSpacing) * sysSpacing;
	
	var _yChange = previousCamY - _holdCamY;

	var _sysSet = sysCollection;
	var _startY = (((is_undefined(forcePosition) ? previousCamY : forcePosition) - sysUpdateRange) div sysSpacing) * sysSpacing;
	var _depthOfInitial = -_startY;
	currentSysEdge = (currentSysEdge + (_yChange div sysSpacing)) % sysCount;
	if(currentSysEdge < 0) {
		currentSysEdge += sysCount;
	}
	var _sysAddI = currentSysEdge;

	var _depthSet = _depthOfInitial;
	repeat(sysCount) {
		part_system_depth(_sysSet[_sysAddI], _depthSet);
		if(OWPshowDebug) particleLayerDepthArray[_sysAddI] = _depthSet;
		_sysAddI += 1;
		_depthSet -= sysSpacing;
		if(_sysAddI >= sysCount) {
			_sysAddI = 0;
		}
	}
}

moveCollection = function() { // camY here should be switched with goal screen top and you can move it as you wish, though, perhaps that would never happen anyway
	var _camY = (camera_get_view_y(view_camera[0]) div sysSpacing) * sysSpacing;
	var _depthChange = abs(previousCamY - _camY)
	
	if(_depthChange >= (sysUpdateRange div sysSpacing) * sysSpacing / 2) { // margins are updated when they reach half the size, this is arbitrary
		
		var _depthAdjustOverflow = 0;
		if(_depthChange >= sysSpacing * sysCount) { // wrapped more than a whole screen at once just jump to the set position functions instead
			setCollectionPosition();
			return;
		}
		
		var _stepSign = sign(_camY - previousCamY); // which way to iterate the list updating depths
		var _isStepForward = _stepSign == 1 ? 1 : 0;
		
		//var _updateDepth = particleLayerDepthArray[currentSysEdge - _isStepForward]; // round the depth and offset by origin (also the first layer is 0 so -1 to the count when multiplying)
		
		var _updateDepth = -previousEdgeY;
		if(_isStepForward) {
			_updateDepth -= sysCount * sysSpacing;
		}
		
		var _updatePos = currentSysEdge - _isStepForward;
		repeat((_depthChange div sysSpacing) % sysCount) {
			_updateDepth -= _stepSign * sysSpacing;
			_updatePos = (_updatePos + _stepSign + sysCount) % sysCount;
			
			part_system_depth(sysCollection[_updatePos], _updateDepth);
			if(OWPshowDebug) particleLayerDepthArray[_updatePos] = _updateDepth;
		}
		
		previousCamY = _camY;
		previousEdgeY = previousCamY - sysUpdateRange;
		currentSysEdge = _updatePos + _isStepForward;
	}
}

/// @desc Pauses drawing and updating of all systems
pauseAll = function() {
	var _sysSet = sysCollection;
	var _sys;
	for(var _i = sysCount - 1; _i >= 0; _i--) {
		_sys = _sysSet[_i];
		part_system_automatic_draw(_sys, false); // if you draw the particle systems yourself then you'll have to custom write this part, though it's the easy part of all of this so you'll be fine
		part_system_automatic_update(_sys, false);
	}
	
	//remove these if you don't use these two systems
	part_system_automatic_draw(global.sysBottom, false);
	part_system_automatic_update(global.sysBottom, false);
	part_system_automatic_draw(global.sysTop, false);
	part_system_automatic_update(global.sysTop, false);
}

/// @desc Resumes drawing and updating of all systems
unpauseAll = function() {
	var _sysSet = sysCollection;
	var _sys = -1;
	for(var _i = sysCount - 1; _i >= 0; _i--) {
		_sys = _sysSet[_i];
		part_system_automatic_draw(_sys, true); // if you draw the particle systems yourself then you'll have to custom write this part, though it's the easy part of all of this so you'll be fine
		part_system_automatic_update(_sys, true);
	}
	
	//remove these if you don't use these two systems
	part_system_automatic_draw(global.sysBottom, true);
	part_system_automatic_update(global.sysBottom, true);
	part_system_automatic_draw(global.sysTop, true);
	part_system_automatic_update(global.sysTop, true);
}

if(OWPshowDebug) particleLayerDepthArray = array_create(sysCount, 0); // init debug array