/// @desc  Creates particles that are assigned and managed by the openWorldParticles depth system. (This version of the script has random ranges, no color, but is also slower because of the split up particle create calls)
/// @param {any*} part  The particle index/type to create
/// @param {any*} xx  The x position to create the particle at
/// @param {any*} yy  The y position to create the particle at
/// @param {any*} quantity  The amount of particles to create
/// @param {any*} [color]  The blending of the particle to create
/// @param {real} [createDepth]  The depth to create the particles at (defaults to depth = -y) This depth will be rounded to the nearest system so the result depth depends on the system accuracy, do every pixel if you want pixel perfect..
/// @param {any*} [placementRange]=0 The random_range to add or subtract from the position of the particle when placed, using a radial placement (which also implies center clustering)
/// @param {any*} [depthRange]=0 The random_range to add or subtract from the depth result of the particle when placed
function OWP_createPartDepthExt(part, xx, yy, quantity, createDepth = undefined, placementRange = 0, depthRange = 0) {
	gml_pragma("forceinline"); 
	
	with(global.sysManager) { 
		var _x, _y, _depth, _placeDir, _placeDist, _layer;
		
		repeat(quantity) {
			if(placementRange != 0) {
				_placeDir = random(360);
				_placeDist = random(placementRange);
				_x = xx + lengthdir_x(_placeDist, _placeDir);
				_y = yy + lengthdir_y(_placeDist, _placeDir);
			}
			
			createDepth ??= -_y;
			
			if(depthRange != 0) {
				_depth = createDepth + random_range(-depthRange, depthRange);
			}
			
			_layer = (currentSysEdge + ((-_depth) - previousEdgeY) div sysSpacing) % sysCount;
			if(_layer < 0) {
				_layer += sysCount;
			}
			
			part_particles_create(sysCollection[_layer], _x, _y, part, 1);
		}
	}
}

///@desc Creates particles that are assigned and managed by the openWorldParticles depth system. (This version of the script has ranges AND colors but is also slower because of the split up particle create calls)
///@param part The particle index/type to create
///@param xx The x position to create the particle at
///@param yy The y position to create the particle at
///@param quantity The amount of particles to create 
///@param color The blending of the particle to create 
///@param {REAL} createDepth The depth to create the particles at (defaults to depth = -y) This depth will be rounded to the nearest system so the result depth depends on the system accuracy, do every pixel if you want pixel perfect.. Also, if you want the particles to force to a depth even though they've placed randomly up or down then you have to manually force depth = -y, if you leave it undefined it will set the depth to the randomly altered y position if you give it a placement range
/// @param {any*} [placementRange]=0 The random_range to add or subtract from the position of the particle when placed, using a radial placement (which also implies center clustering)
/// @param {any*} [depthRange]=0 The random_range to add or subtract from the depth result of the particle when placed
function OWP_createPartDepthExtColor(part, xx, yy, quantity, color = undefined, createDepth = undefined, placementRange = 0, depthRange = 0) {
	gml_pragma("forceinline"); 
	
	with(global.sysManager) { 
		var _x, _y, _depth, _placeDir, _placeDist, _layer;
		
		repeat(quantity) {
			if(placementRange != 0) {
				_placeDir = random(360);
				_placeDist = random(placementRange);
				_x = xx + lengthdir_x(_placeDist, _placeDir);
				_y = yy + lengthdir_y(_placeDist, _placeDir);
			}
			
			createDepth ??= -_y;
			
			if(depthRange != 0) {
				_depth = createDepth + random_range(-depthRange, depthRange);
			}
			
			_layer = (currentSysEdge + ((-_depth) - previousEdgeY) div sysSpacing) % sysCount;
			if(_layer < 0) {
				_layer += sysCount;
			}
			
			part_particles_create_color(sysCollection[_layer], _x, _y, part, color, 1); // the reason extColor is seperate from ext is because unlike the simple version you'd have to check color for every particle, not just the whole bunch, so that might be 20, 50, 200, ect extra checks for color. Easy enough to just split them up.. Though you know what to do if you don't like that, loop the color check and combine the two scripts
		}
	}
}

//simple version, fast
///@desc Creates particles that are assigned and managed by the openWorldParticles depth system. (simple, fast version, use Ext version for random ranges or ExtColor for color and ranges)
///@param part The particle index/type to create
///@param xx The x position to create the particle at
///@param yy The y position to create the particle at
///@param quantity The amount of particles to create 
///@param color The blending of the particle to create 
///@param {REAL} createDepth The depth to create the particles at (defaults to depth = -y) This depth will be rounded to the nearest system so the result depth depends on the system accuracy, do every pixel if you want pixel perfect..
function OWP_createPartDepth(part, xx, yy, quantity, color = undefined, createDepth = -yy){
	gml_pragma("forceinline");
	
	with(global.sysManager) { 
		var _layer = (currentSysEdge + (yy - previousEdgeY) div sysSpacing) % sysCount;
		if(_layer < 0) {
			_layer += sysCount;
		}
		
		if(is_undefined(color)) {
			part_particles_create(sysCollection[_layer], xx, yy, part, quantity);
		} else {
			part_particles_create_color(sysCollection[_layer], xx, yy, part, color, quantity); // did you know particle blending is absolute? It's not a mixed value it's an overwrite of sorts.
		}
	}
}