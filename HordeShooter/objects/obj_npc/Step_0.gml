// from here on is basically just free control, no formal dialogue interaction and no speaker id to react to so there's no dialogue happening, I need to clean this though
randomCommentTimer--;
if(randomCommentTimer <= 0) {
	sayRandomComment();
}
	
if(keyboard_check_released(ord("E"))) {
	var _player = instance_nearest(x,y, obj_player); // same s different inputs
	if(instance_exists(_player)) {
		if(point_distance(x, y, _player.x, _player.y) < 100) {
			talkDictionary(_player);
		}
	}
}

if(pathMoving) {
	#region moving on a path
	moveDelay--;
	if(moveDelay <= 0) {
		speed = 0;
		if(irandom(moveStartChance) == 0) {
			var _speed = random(moveSpeed);
			var _pointDir = point_direction(x, y, pathGoalX, pathGoalY);
		
			motion_set(_pointDir, moveSpeed);
			moveDelay = irandom_range(60, 420);
		}
	} else {
		if(point_distance(x, y, pathGoalX, pathGoalY) < pathGoalRadius) {
			if((path_position == 1 && pathIncrement > 0) || (path_position == 0 && pathIncrement < 0)) { // if moving towards end, check this after set to let the instance get to the end before marking it
				if(!path_get_closed(pathCurrent) || (current_time - pathCurrentStartTime > 5000)) { // eh..? A circular path must be followed for at least 2.5 seconds to break on loop... this is a janky way to prevent jumping back and forth between starts and close points... Remake this at some point I guess I don't know.
					var _pathInfo = script_chooseNextPath(pathCurrent, path_position, id);
					startPathMovement(_pathInfo[0], _pathInfo[1], _pathInfo[2]);
				} else { // failed circular path
					path_position = 1 - path_position;
				}
			}
		
			var _prevPathPos = path_position;
		
			path_position += (pathIncrement) / pathCurrentLength; // move 20 pixels before re-establishing point
		
			if(path_position > 1) {
				path_position = 1;
			} else if(path_position < 0) { //.this is goal setting so don't loop, it wont affect speed just logic
				path_position = 0;
			}
			
			var _pointCrossed = pathPointOfInterestPassed(_prevPathPos, path_position);
			if(_pointCrossed != -1) {
				var _pathInfo = script_chooseNextPath(pathCurrent, _pointCrossed, id);
				startPathMovement(_pathInfo[0], _pathInfo[1], _pathInfo[2]);
			} else {
				//if crossed any points of interest (branches, maybe pauses or something else) then recheck your path setting with (choose next path))
				pathGoalX = path_get_x(pathCurrent, path_position);
				pathGoalY = path_get_y(pathCurrent, path_position);
		
				var _pointDir = point_direction(x, y, pathGoalX, pathGoalY);
		
				motion_set(_pointDir, moveSpeed);
			}
		}
	}
	#endregion
} else if(followingPoint) {
	
	if(irandom(5) == 0) {
		ds_list_clear(npcAroundList)
		collision_circle_list(x, y, 200, obj_npc, false, true, npcAroundList, true); // get nearby npcs
		npcAroundCount = ds_list_size(npcAroundList);
		
		var _monster = instance_nearest(x, y, obj_monster);
		var _monsterDist = -1;
		if(_monster != noone) {
			_monsterDist = point_distance(x,y, _monster.x, _monster.y);
			followPointX = _monster.x;
			followPointY = _monster.y;
			
			var _monsterDir = point_direction(x,y, _monster.x, _monster.y);
			motion_add(_monsterDir, .35);
			
			if(attackTimer <= 0) {
				if(_monsterDist < 60) {
					attack(point_direction(x,y, _monster.x, _monster.y), 20);
				}
			}
		}
		if(_monsterDist == -1) {
			if(instance_exists(followingId)) {
				followPointX = followingId.x + followingId.hspeed * 14;
				followPointY = followingId.y + followingId.vspeed * 14;
			} else if(followingId != noone) {
				followingId = noone;
				followingPoint = false;
			}
		}
			
		var _dist = point_distance(x, y, followPointX, followPointY);
		var _dir = point_direction(x, y, followPointX, followPointY);
		
		var _approachSpeed = clamp(_dist / 70 - 1, -.25, 12);
		
		if(_approachSpeed < 0) {
			_approachSpeed = _approachSpeed * 1;
			if(followingId == noone) {
				followingPoint = false; // close enough to cancel follow of point
			}
		} else {
			_approachSpeed = clamp((_approachSpeed - 1.5) / 7, 0, 2.2);
		}
		
		motion_add(_dir, _approachSpeed);
			
		#region avoiding stuff (janky?)
		var _avoiding = true; // as you go up check the avoid vs approach difference to see if you should check for this
	
		
		if(npcAroundCount > 0) {
			#region variable setting
			var _approachX = 0;
			var _approachY = 0;
		
			var _initialSpeedX = hspeed;
			var _initialSpeedY = vspeed;
			
			speed = 0;
			
			var _avoidDir = 0;
			var _avoidDist = 0;
			
			var _enemy = noone;
			var _enemyX = 0;
			var _enemyY = 0;
			#endregion
			
			for(var _i = 0; _i < npcAroundCount; _i++) {
				_enemy = npcAroundList[| _i];
				_enemyX = _enemy.x;
				_enemyY = _enemy.y;
				
				_approachX += _enemyX;
				_approachY += _enemyY;
				
				if(_avoiding) {
					_avoidDist = point_distance(_enemyX, _enemyY, x, y);
					if(_avoidDist < 26) {
						_avoidDir = point_direction(_enemyX, _enemyY, x, y);
						
						motion_add(_avoidDir, 22 / max(power(_avoidDist, .75), 2));
					} else {
						_avoiding = false;
					}
				}
			}
	
			_approachX /= npcAroundCount;
			_approachY /= npcAroundCount;
			
			speed = min(speed / npcAroundCount, .7);
			
			var _approachDir = point_direction(x, y, _approachX, _approachY);
			var _approachDist = point_distance(x, y, _approachX, _approachY); // move towars center of mass
			motion_add(_approachDir, (1 - (_approachDist / 200)) / 110);
			
			hspeed += _initialSpeedX;
			vspeed += _initialSpeedY;
		}
		#endregion
		
		if(instance_exists(followingId) && object_is_ancestor(followingId.object_index, obj_radiantObject) && point_distance(followingId.x, followingId.y, x, y) > followingId.range * .6) {
			motion_add(_dir, .3);
		}
	}
}





if(irandom(5) == 0) {
	ds_list_clear(npcAroundList)
	collision_circle_list(x, y, 400, obj_npc, false, true, npcAroundList, true); // get nearby npcs
	npcAroundCount = ds_list_size(npcAroundList);
		
	var _dist = point_distance(x, y, followPointX, followPointY);
	var _dir = point_direction(x, y, followPointX, followPointY);
	
	var _approachSpeed = clamp(_dist / 70 - 1, -.25, 12);
	
	if(_approachSpeed < 0) {
		_approachSpeed = _approachSpeed * 1;
		if(followingId == noone) {
			followingPoint = false; // close enough to cancel follow of point
		}
	} else {
		_approachSpeed = clamp((_approachSpeed - 1.5) / 7, 0, 2.2);
	}
	
	motion_add(_dir, _approachSpeed);
		
	#region avoiding stuff (janky?)
	var _avoiding = true; // as you go up check the avoid vs approach difference to see if you should check for this

	
	if(npcAroundCount > 0) {
		var _approachX = 0;
		var _approachY = 0;
	
		var _initialSpeedX = hspeed;
		var _initialSpeedY = vspeed;
		
		speed = 0;
		
		var _avoidDir = 0;
		var _avoidDist = 0;
		
		var _enemy = noone;
		var _enemyX = 0;
		var _enemyY = 0;
		#endregion
		
		for(var _i = 0; _i < npcAroundCount; _i++) {
			_enemy = npcAroundList[| _i];
			_enemyX = _enemy.x;
			_enemyY = _enemy.y;
			
			_approachX += _enemyX;
			_approachY += _enemyY;
			
			if(_avoiding) {
				_avoidDist = point_distance(_enemyX, _enemyY, x, y);
				if(_avoidDist < 26) {
					_avoidDir = point_direction(_enemyX, _enemyY, x, y);
					
					motion_add(_avoidDir, 22 / max(power(_avoidDist, .75), 2));
				} else {
					_avoiding = false;
				}
			}
		}

		_approachX /= npcAroundCount;
		_approachY /= npcAroundCount;
		
		speed = min(speed / npcAroundCount, .7);
		
		var _approachDir = point_direction(x, y, _approachX, _approachY);
		var _approachDist = point_distance(x, y, _approachX, _approachY); // move towars center of mass
		motion_add(_approachDir, (1 - (_approachDist / 200)) / 110);
		
		hspeed += _initialSpeedX;
		vspeed += _initialSpeedY;
	}
}