///@desc  Creates particles that are assigned and managed by the openWorldParticles depth system. (This version of the script has random ranges, no color, but is also slower because of the split up particle create calls)
///@param part The particle index/type to create
///@param xx The x position to create the particle at
///@param yy The y position to create the particle at
///@param quantity  The amount of particles to create
///@param [createDepth]  The depth to create the particles at (defaults to depth = -y) This depth will be rounded to the nearest system so the result depth depends on the system accuracy, set spacing to 1 if you want pixel perfect..
///@param [placementRange]=0 The random_range to add or subtract from the position of the particle when placed, using a radial placement (which also implies center clustering)
///@param [depthRange]=0 The random_range to add or subtract from the depth result of the particle when placed
///@param [createdPerBatch]=1 The amount of particles to create per loop, this is a lag mitigation thing, the particles grouped like this won't have seperate depths or positions but if you want 1000 particles it can be faster to create 20 particles in 50 randomized batches then to do the whole thing 1000 times... Leave this as one if you want every particle to be uniquely placed and depthed, it'll be fine like that probably
function OWP_createPartExt(part, xx, yy, quantity, createDepth = undefined, placementRange = 0, depthRange = 0, createdPerBatch = 1) {
	//gml_pragma("forceinline"); 
	
	quantity /= createdPerBatch;
	
	with(global.sysManager) { 
		var _x, _y, _depth, _placeDir, _placeDist, _layer;
		
		repeat(quantity) {
			if(placementRange != 0) {
				_placeDir = random(360);
				_placeDist = random(placementRange);
				_x = xx + lengthdir_x(_placeDist, _placeDir);
				_y = yy + lengthdir_y(_placeDist, _placeDir);
			} else {
				_x = xx;
				_y = yy;
			}
			
			createDepth ??= -_y;
			
			_depth = createDepth;
			if(depthRange != 0) {
				 _depth += random_range(-depthRange, depthRange);
			}
			
			_layer = (currentSysEdge + ((-_depth) - previousEdgeY) div sysSpacing) % sysCount;
			if(_layer < 0) {
				_layer += sysCount;
			}
			
			part_particles_create(sysCollection[_layer], _x, _y, part, createdPerBatch);
		}
	}
}

///@desc Creates particles that are assigned and managed by the openWorldParticles depth system. (This version of the script has ranges AND colors but is also slower because of the split up particle create calls)
///@param part The particle index/type to create
///@param xx The x position to create the particle at
///@param yy The y position to create the particle at
///@param quantity The amount of particles to create 
///@param color The blending of the particle to create 
///@param createDepth The depth to create the particles at (defaults to depth = -y) This depth will be rounded to the nearest system so the result depth depends on the system accuracy, set spacing to 1 if you want pixel perfect.. Also, if you want the particles to force to a depth even though they've placed randomly up or down then you have to manually force depth = -y, if you leave it undefined it will set the depth to the randomly altered y position if you give it a placement range
///@param [placementRange]=0 The random_range to add or subtract from the position of the particle when placed, using a radial placement (which also implies center clustering)
///@param [depthRange]=0 The random_range to add or subtract from the depth result of the particle when placed
///@param [createdPerBatch]=1 The amount of particles to create per loop, this is a lag mitigation thing, the particles grouped like this won't have seperate depths or positions but if you want 1000 particles it can be faster to create 20 particles in 50 randomized batches then to do the whole thing 1000 times... Leave this as one if you want every particle to be uniquely placed and depthed, it'll be fine like that probably
function OWP_createPartExtColor(part, xx, yy, quantity, color = undefined, createDepth = undefined, placementRange = 0, depthRange = 0, createdPerBatch = 1) {
	//gml_pragma("forceinline"); 
	
	quantity /= createdPerBatch;
	
	with(global.sysManager) { 
		var _x, _y, _depth, _placeDir, _placeDist, _layer;
		
		repeat(quantity) {
			if(placementRange != 0) {
				_placeDir = random(360);
				_placeDist = random(placementRange);
				_x = xx + lengthdir_x(_placeDist, _placeDir);
				_y = yy + lengthdir_y(_placeDist, _placeDir);
			} else {
				_x = xx;
				_y = yy;
			}
			
			createDepth ??= -_y;
			
			_depth = createDepth;
			if(depthRange != 0) {
				 _depth += random_range(-depthRange, depthRange);
			}
			
			_layer = (currentSysEdge + ((-_depth) - previousEdgeY) div sysSpacing) % sysCount;
			if(_layer < 0) {
				_layer += sysCount;
			}
			
			part_particles_create_color(sysCollection[_layer], _x, _y, part, color, createdPerBatch); // the reason extColor is seperate from ext is because unlike the simple version you'd have to check color for every particle, not just the whole bunch, so that might be 20, 50, 200, ect extra checks for color. Easy enough to just split them up.. Though you know what to do if you don't like that, loop the color check and combine the two scripts
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
///@param createDepth The depth to create the particles at (defaults to depth = -y) This depth will be rounded to the nearest system so the result depth depends on the system accuracy, set spacing to 1 if you want pixel perfect..
function OWP_createPart(part, xx, yy, quantity, color = undefined, createDepth = -yy){ 
	//gml_pragma("forceinline");
	
	with(global.sysManager) { 
		var _layer = (currentSysEdge + ((-createDepth) - previousEdgeY) div sysSpacing) % sysCount;
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

//you can make your own scripts of course, just make sure they calculate the layer the same way that these do, which is essentially finding the "rolled position" of the particle based on the depth you want, everything else, the looping, ranges, colors, ect is just what I like and use
//you can also return the _layer result of the calculation if you for some reason want the script to tell you what layer it placed the... most recent particle in, I dunno