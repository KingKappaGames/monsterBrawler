///@desc This function takes a sprite and image and some positions and creates lots of debris pieces out of a grid from that sprite, essentially shredding it and throwing pieces. Can also do interior images if given.
///@param sprite This is what sprite to use for the main break apart
///@param image This is which image to use from the main sprite
///@param gridWidth This is how many pixels wide to make the pieces of the sprite
///@param gridHeight This is how many pixels tall to make the pieces of the sprite
///@param burstInfo This is an array of values representing burstCenterX, The X on the sprite, burstCenterY, The Y on the sprite, burstPower, Burst speed multiplier, burstHeight, Burst height multiplier, burstAdjustSpeedX, The flat xChange for all pieces, burstAdjustSpeedY, The flat yChange for all pieces, burstRadius, the range of the burst in pixels
///@param drawToGround This is whether or not the pieces will draw to the debris surface after expiring
///@param interiorColor This is either a color value to redisintegrate the sprite with or a second sprite to disintegrate
///@param interiorPieces This is the image to use for interior sprite if you are using a sprite for interior
function script_disintegrateObject(sprite = sprite_index, image = image_index, gridWidth = 4, gridHeight = 4, burstInfo = [-1, -1, .3, 1, undefined, undefined, -1], drawToGround = 1, interiorColor = c_blue, interiorPieces = 1) {
	//msg(current_time);
	//var _isInteriorSprite = asset_get_type(interiorSpriteOrColor) == asset_sprite; // equivalency, boolean. With the interior as a sprite this matters same with the image set value that no longer exists
	
	#region making and setting up surfaces
	var _mainWidth =  sprite_get_width(sprite);
	var _mainHeight =  sprite_get_height(sprite);
	var _mainSurf = surface_create(_mainWidth, _mainHeight);
	var _mainBuffer = buffer_create(_mainWidth * _mainHeight * 4, buffer_fixed, 1);
	surface_set_target(_mainSurf);
	draw_sprite_ext(sprite, image, sprite_get_xoffset(sprite), sprite_get_yoffset(sprite), 1/*scale x/y, rotation?..*/, 1, 1, c_white, 1);
	surface_reset_target();
	buffer_get_surface(_mainBuffer, _mainSurf, 0);
	// draw the images into place with draw sprite because draw sprite does not include texture page artifacts... Get a clean canvas for pulling from
	/*if(_isInteriorSprite) {
		var _interiorWidth =  sprite_get_width(interiorSpriteOrColor);
		var _interiorHeight =  sprite_get_height(interiorSpriteOrColor);
		var _interiorSurf = surface_create(_interiorWidth, _interiorHeight);
		var _interiorBuffer = buffer_create(_interiorWidth * _interiorHeight * 4, buffer_fixed, 1);
		surface_set_target(_interiorSurf);
		draw_sprite_ext(interiorSpriteOrColor, interiorImage, sprite_get_xoffset(interiorSpriteOrColor), sprite_get_yoffset(interiorSpriteOrColor), 1, 1, 1, c_white, 1); // scale roation color?
		surface_reset_target();
		buffer_get_surface(_interiorBuffer, _interiorSurf, 0);
	}*/
	#endregion
	
	var _spriteLeft = x - sprite_get_xoffset(sprite);
	var _spriteTop = y - sprite_get_yoffset(sprite);
	var _visualBottom = -1; // for piece height setting
	
	#region default burst values
	if(burstInfo[0] == -1) {
		burstInfo[0] = _mainWidth / 2;
	}
	if(burstInfo[1] == -1) {
		burstInfo[1] = _mainHeight / 2;
	}
	if(burstInfo[6] == -1) {
		burstInfo[6] = _mainWidth / 4 + _mainHeight / 4;
	}
	
	burstInfo[4] = burstInfo[4] ?? hspeed;
	burstInfo[5] = burstInfo[5] ?? -vspeed;
	#endregion
	
	var _xSpeed = 0;
	var _ySpeed = 0;
	var _heightSpeed = 0;
	var _dir = 0;
	var _distToImpact = 0;
	
	var _sectionEmpty = 1; // for each section of the image to check start with not drawing and decide to draw if you find pixels
	var _gridChunksHor = ceil(_mainWidth / gridWidth);
	var _gridChunksVer = ceil(_mainHeight / gridHeight);
	for(var _gridY = _gridChunksVer - 1; _gridY >= 0; _gridY--) {
		for(var _gridX = 0; _gridX < _gridChunksHor; _gridX++) {
			_sectionEmpty = 1;

			var _sequenceLength = clamp(gridWidth, 0, _mainWidth - _gridX * gridWidth); // get the amount of pixels (horizontal) to do in a row, clipped by the edge of the image.
			var _sequenceJump = _mainWidth - _sequenceLength;
			var _sequenceRepeats = clamp(gridHeight, 0, _mainHeight - _gridY * gridHeight);
			
			buffer_seek(_mainBuffer, buffer_seek_start, (_gridX * gridWidth + (_gridY * gridHeight * _mainWidth)) * 4);
			repeat(_sequenceRepeats) { // this set's the position to the next line of the image which is now a line's width down the list because it's one after another instead of 2d grids.
				repeat(_sequenceLength) {
					if(buffer_read(_mainBuffer, buffer_u8) != 0) {
						_sectionEmpty = 0;
						break; // this section reads a horizontal line of however many pixels doing every fourth for alpha. Breaks if pixel found.
					}
					buffer_seek(_mainBuffer, buffer_seek_relative, 3);
				}
				if(_sectionEmpty == 0) {
					break;
				}
				buffer_seek(_mainBuffer, buffer_seek_relative, _sequenceJump * 4); // skip to next lines segment of horizontal pixels (4 because 4 colors)
			}
			
			
			// if you wanted to move the tiles so that they were centered isntead of top left for scattering you could ust move the origin of the scatter left and up half grids.
			if(_sectionEmpty == 0) {
				if(_visualBottom == -1) {
					_visualBottom = (_gridY + 1) * gridHeight;
				}
				_dir = point_direction(burstInfo[0], burstInfo[1], _gridX * gridWidth, _gridY * gridHeight);
				_distToImpact = point_distance(burstInfo[0], burstInfo[1], _gridX * gridWidth, _gridY * gridHeight);
				_xSpeed = burstInfo[4] + dcos(_dir) * (burstInfo[6] / (_distToImpact + 10)) * burstInfo[2];
				_ySpeed = burstInfo[5] + dsin(_dir) * (burstInfo[6] / (_distToImpact + 10)) * burstInfo[2];
				_heightSpeed = -dsin(_dir) * (burstInfo[6] / (_distToImpact + 5)) * burstInfo[2] * burstInfo[3];
				
				var _debrisPiece = script_createDebris(sprite, image, 2, _spriteLeft + _gridX * gridWidth, _spriteTop + _visualBottom, obj_ChunkOfSpriteDebris, 60 + irandom(40), _xSpeed * random_range(.3, .7) + random_range(-.3, .3), _ySpeed * random_range(.3, .7) + random_range(-.3, .3), random_range(-12, 12), .8, .5, _visualBottom - _gridY * gridHeight, _heightSpeed * random_range(.3, 1.5) + random_range(-.7, 1.2), 0, drawToGround);
				_debrisPiece.drawX = _gridX * gridWidth;
				_debrisPiece.drawY = _gridY * gridHeight; // with calculated angles and distances for this section draw this main tile piece, then go down to interior sprite and since it's the same shape and sprite just use the same values adjusted with the same randoms
				_debrisPiece.drawWidth = _sequenceLength;
				_debrisPiece.drawHeight = _sequenceRepeats;
				
				//if(!_isInteriorSprite) {
				repeat(interiorPieces) { // it looks better if the pieces are more common for interior since volume is more than skin ya know?
					var _debrisPieceInterior = script_createDebris(sprite, image, 2, _spriteLeft + _gridX * gridWidth, _spriteTop + _visualBottom, obj_ChunkOfSpriteDebris, 60 + irandom(40), _xSpeed * random_range(.3, .7) + random_range(-.3, .3), _ySpeed * random_range(.3, .7) + random_range(-.3, .3), random_range(-12, 12), .8, .4, _visualBottom - _gridY * gridHeight, _heightSpeed * random_range(.3, 1.5) + random_range(-.7, 1.2), 0, drawToGround);
					_debrisPieceInterior.drawX = _gridX * gridWidth;
					_debrisPieceInterior.drawY = _gridY * gridHeight; // use values determined above to create pieces but with another random adjustment
					_debrisPieceInterior.drawWidth = _sequenceLength;
					_debrisPieceInterior.drawHeight = _sequenceRepeats;
					_debrisPieceInterior.image_blend = make_color_rgb(irandom(255), irandom(255), irandom(255));//interiorColor;
				}
				//}
			} // still need to do interior stuff. Maybe. ###########################
			/*
			if(_isInteriorSprite) {
				_xSpeed = burstInfo[4] + random_range(-.75, .75);
				_ySpeed = burstInfo[5] + random_range(-.75, .75);
				_heightSpeed = burstInfo[2] * burstInfo[3] * 0 + random_range(-1.5, 1.5)
				;
				var _debrisPieceInterior  = script_createDebris(interiorSpriteOrColor, interiorImage, 2, _spriteLeft + _gridX * gridWidth, _spriteTop + _gridY * gridHeight, obj_ChunkOfSpriteDebris, 60 + irandom(40), _xSpeed, _ySpeed, random_range(-12, 12), .9, .6, 1, _heightSpeed, 0, drawToGround);
				_debrisPieceInterior.drawX = _gridX * gridWidth;
				_debrisPieceInterior.drawY = _gridY * gridHeight;
				_debrisPieceInterior.drawWidth = gridWidth; // this whole function is just for readability
				_debrisPieceInterior.drawHeight = gridHeight;
			} else {
			*/
		}
	}
	
	surface_free(_mainSurf);
	//if(_isInteriorSprite) {
	//	surface_free(_interiorSurf); // die die die
	//}
	buffer_delete(_mainBuffer);
	//if(_isInteriorSprite) {
	//	buffer_delete(_interiorBuffer);
	//}
	//msg(current_time);
}