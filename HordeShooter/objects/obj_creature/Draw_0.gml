//if (live_call()) return live_result;

draw_ellipse_color(x - sprite_width * .3, y + 15, x + sprite_width * .3, y + 25, #111111, #111111, false); // shadow

if(hitFlash > 0) {
	shader_set(shd_hitFlash);
} else {
	shader_set(shd_brightness);
	if(alwaysBurning) {
		shader_set_uniform_f(shader_get_uniform(shd_brightness, "strength"), 0);
	} else {
		shader_set_uniform_f(shader_get_uniform(shd_brightness, "strength"), -min(.8, burning * .02));
	}
}

if(useSkeletonAnimations) {
	bodySurf = getBodySurf();
	
	surface_set_target(bodySurf);
	
	draw_clear_alpha(c_black, 0);
	
	var _animation = skeletonData[skeletonAnimation];
	var _frame = _animation[image_index];
	
	var _rigAnimation = skeletonRigData[skeletonAnimation];
	var _rigFrame = _rigAnimation[image_index];
	
	var _bodyPart, _rigBodyPart;
	for(var _i = bodyPartCount - 1; _i >= 0; _i--) {
		_bodyPart = _frame[_i];
		if(_bodyPart[0] != -1) { // don't draw part frames marked as blank (-1)
			_rigBodyPart = _rigFrame[_i];
			draw_sprite_ext(_bodyPart[0], _bodyPart[1], bodySurfSize * .5 + _rigBodyPart[0], bodySurfSize * .5 + _rigBodyPart[1], 1, 1, _rigBodyPart[2], c_white, 1);
		}
	}
	
	surface_reset_target();
		
	var _surfCornerDist = bodySurfSize * squareDist;
	var _surfX, _surfY;
	if(directionFacing == 1) {
		_surfX = x + (lengthdir_x(_surfCornerDist, 135 + image_angle)) * image_xscale;
		_surfY = y + (lengthdir_y(_surfCornerDist, 135 + image_angle)) * image_yscale; 
	} else {
		_surfX = x + (lengthdir_x(_surfCornerDist, 45 + image_angle)) * image_xscale;
		_surfY = y + (lengthdir_y(_surfCornerDist, 45 + image_angle)) * image_yscale; 
	}
	draw_surface_ext(bodySurf, _surfX, _surfY - height, directionFacing * image_xscale, image_yscale, image_angle, image_blend, image_alpha);
} else {
	draw_sprite_ext(sprite_index, image_index, x, y - height, directionFacing * image_xscale, image_yscale, image_angle, image_blend, image_alpha);
}

shader_reset();

if(frozen) {
	draw_sprite_ext(spr_iceBlock, 0, x, y, sprite_width / 32, sprite_height / 32, 0, c_white, .9);
}

if(global.showDebug) {
	draw_line(x, y, x, y - Health * 3);
	draw_text_transformed(x, y - Health * 3 - 10, Health, .75, .75, 0);
	
	draw_text(x, y + 60, SM.get_current_state());
	draw_text(x, y + 80, stateTimer);
}

//SM.draw();

//draw_text(x + 100, y, image_index);

//draw_circle(x, y, 2, true)