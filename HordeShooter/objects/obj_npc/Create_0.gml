//STRIPPED DOWN CODE OBJECT FROM DICTDIALOGUE, DONT CODE THIS

interactionRange = 65;

#region movement, pathing, and ai steering behaviors
moveDelay = 0;
moveStartChance = 120;

pathMoving = 0;

speed = 0;
moveSpeed = 2.8;
speedDecay = .98;

followingPoint = false;
followPointX = 0;
followPointY = 0;
followingId = noone;
leader = false;
npcAroundList = ds_list_create();
npcAroundCount = 0;

pathCurrent = noone;
pathGoalX = 0;
pathGoalY = 0;
pathGoalRadius = 15;
pathIncrementBase = 20;
pathIncrement = pathIncrementBase; // pixels (negative or positive)

pathPredictDist = 50;

pathCurrentStartTime = current_time;

pathPOIs = [];
#endregion


///@desc Increment can be negative! -1 for no position change, -2 for calculate closet point to goal path
startPathMovement = function(path = pathCurrent, pathFollowIncrement = pathIncrement, position = path_position) {
	if(path_exists(path)) {
		pathMoving = true;
		pathCurrent = path;
		pathCurrentStartTime = current_time; // game time (switch)
	
		pathCurrentLength = path_get_length(path);
		
		pathIncrement = pathIncrementBase * pathFollowIncrement;
		
		if(position != -1 && position != -2) { // none key word, set position
			path_position = position;
		} else if(position == -2) { // if key word -2 calculate position
			path_position = script_getClosestPathPosition(pathCurrent, x, y, 30, pathCurrentLength, 40) + (sign(pathIncrement) * (pathPredictDist / pathCurrentLength)); // add prediction dist to point of entry to simulate cutting the paths a little in the direction you're headed, you don't just cut straight to the cloest point when switching paths in real life, you take the most direct path
		} // else (-1) keep old position
		
		pathGoalX = path_get_x(pathCurrent, path_position);
		pathGoalY = path_get_y(pathCurrent, path_position);
		
		pathPOIs = script_getPathPOIs(pathCurrent);
		
		var _pointDir = point_direction(x, y, pathGoalX, pathGoalY);
		motion_set(_pointDir, moveSpeed);
	}
}

///@desc Given a length of path did you pass over a point of interest? If so this will return the exact position of the point of interest so you can check with it, otherwise returns -1
pathPointOfInterestPassed = function(startPos, endPos) {	
	var _genHold = 0;
	
	if(startPos > endPos) {
		_genHold = startPos;
		startPos = endPos; // flip the two points if start is more than end, this makes checking the range easier
		endPos = _genHold;
	}
	
	if(pathPOIs != -1) {
		var _poiCount = array_length(pathPOIs);
		
		//check for passing over pois
		for(var _poi = 0; _poi < _poiCount; _poi++) {
			_genHold = pathPOIs[_poi];
			
			if(_genHold > startPos && _genHold < endPos) {
				return _genHold;
			}
		}
		
		return -1;
	} else {
		return -1;
	}
}

stopPathMovement = function() {
	pathMoving = false;
}
