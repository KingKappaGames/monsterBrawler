/// @desc Function Resets all the sprite indexes and image indexes for the given body part within a skeleton rig, eg, you would pass 2, spr_ to change 
/// @param {any*} bodyPart The part index of the piece to change using E_bodyPart
function script_setSkeletonPart(bodyPart, sprite, image = 0) {
	var _rigData = skeletonData;
	var _animationCount = array_length(_rigData);
	for(var _animationI = 0; _animationI < _animationCount; _animationI++) {
		
		var _animation = _rigData[_animationI];
		var _frameCount = array_length(_animation);
		for(var _frameI = 0; _frameI < _frameCount; _frameI++) {
			var _bodyPart = _animation[_frameI][bodyPart];
			
			if(_bodyPart[0] != -1) {
				_bodyPart[0] = sprite;
				_bodyPart[1] = image;
			}
		}
		
	}
}