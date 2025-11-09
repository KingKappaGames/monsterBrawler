
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

	var _surfHalfW = surface_get_width(bodySurf) * .5;
	var _surfHalfH = surface_get_height(bodySurf) * .5;
	
	surface_set_target(bodySurf);
	
	draw_clear_alpha(c_black, 0);
	
	var _animation = skeletonData[skeletonAnimation];
	var _frame = _animation[image_index];
	
	var _rigAnimation = global.skeletonRigData[skeletonAnimation];
	var _rigFrame = _rigAnimation[image_index];
	
	if(_animation == E_animation.rise) {
		var _gunk = false;
	}
	
	var _bodyPart, _rigBodyPart;
	for(var _i = bodyPartCount - 1; _i >= 0; _i--) {
		_bodyPart = _frame[_i];
		if(_bodyPart[0] != -1) { // don't draw part frames marked as blank (-1)
			_rigBodyPart = _rigFrame[_i];
			draw_sprite_ext(_bodyPart[0], _bodyPart[1], _surfHalfW + _rigBodyPart[0], _surfHalfH + _rigBodyPart[1], 1, 1, _rigBodyPart[2], c_white, 1);
		}
	}
	
	surface_reset_target();
					
	draw_surface_ext_origin(bodySurf, x, y - height, directionFacing * image_xscale, image_yscale, image_angle, image_blend, image_alpha, _surfHalfW, _surfHalfH);
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