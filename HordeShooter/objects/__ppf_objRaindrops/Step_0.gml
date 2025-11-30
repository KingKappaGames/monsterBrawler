
if (!surface_exists(inputSurface)) exit;

// Create raindrops
raindropTimer = max(raindropTimer-1, 0);
if (raindropTimer == 0) {
	array_push(raindropList, {
		sprite : __ppf_sprRainNormal,
		sprite_subimg : 0,
		xx : random_range(0, surfaceWidth),
		yy : 0,
		hmov_amplitude : random_range(0.2, 0.5),
		scale : random_range(0.1, 0.2),
		spd : random_range(1, 3),
		alpha : 1,
		fric : 1,
	});
	raindropTimer = irandom_range(raindropTimerRange1, raindropTimerRange2);
}


rainSurfaceA = __ppf_surface_create_secure_size(rainSurfaceA, surfaceWidth, surfaceHeight, surfaceFormat);
rainSurfaceB = __ppf_surface_create_secure_size(rainSurfaceB, surfaceWidth, surfaceHeight, surfaceFormat);

surface_set_target(rainSurfaceA);
	gpu_push_state();
	gpu_set_tex_filter(true);
	shader_set(__ppf_shBlendNormals);
	// draw rain drops
	// small drop
	gpu_set_blendmode(bm_add);
	//gpu_set_blendmode_ext_sepalpha(bm_src_alpha, bm_one, bm_one, bm_inv_src_alpha); // bm_add, but supports HDR
	if (enableSmallDrops) {
		draw_sprite_ext(__ppf_sprRainNormal, 1, random_range(0, surfaceWidth), random_range(0, surfaceHeight), 1, 1, 0, c_white, raindropsAlpha*0.5);
	}
	// rain drops
	var i = 0, isize = array_length(raindropList);
	repeat(isize) {
		var _reciprocal = i / isize;
		var _drop = raindropList[i];
		var t = current_time*0.001;
		_drop.xx += (sin(t + _drop.spd + sin(t*1.2) * _reciprocal) * _drop.hmov_amplitude) + random_range(-0.5, 0.5);
		_drop.yy += _drop.spd * _drop.fric;
		//_drop.fric = sin(t*0.5*_reciprocal) * 0.2+0.5;
		_drop.scale += random_range(-0.01, 0.01);
		_drop.scale = clamp(_drop.scale, 0.2, 0.8);
		_drop.alpha += choose(0, random_range(-0.02, 0.02))
		
		if (_drop.yy > surfaceHeight+32) {
			array_delete(raindropList, i, 1);
			i -= 1;
		}
		draw_sprite_ext(_drop.sprite, _drop.sprite_subimg, _drop.xx, _drop.yy, _drop.scale, _drop.scale, 0, c_white, _drop.alpha*raindropsAlpha);
		++i;
	}
	draw_set_alpha(1);
	shader_reset();
	gpu_pop_state();
surface_reset_target();


// recursive apply
var _surf1 = rainSurfaceSwap ? rainSurfaceB : rainSurfaceA;
var _surf2 = rainSurfaceSwap ? rainSurfaceA : rainSurfaceB;

rainSurfaceSwap = !rainSurfaceSwap;

surface_set_target(_surf1);
	draw_clear(make_color_rgb(128, 128, 255));
	shader_set(__ppf_shBlurBox4);
	shader_set_uniform_f(shader_get_uniform(__ppf_shBlurBox4, "u_texelSize"), (1/surfaceWidth)*blurScale, (1/surfaceHeight)*blurScale);
	draw_surface(_surf2, 0, 0);
	shader_reset();
	
	draw_sprite_stretched_ext(__ppf_sprNormal, 0, 0, 0, surfaceWidth, surfaceHeight, c_white, blurFadeAmount);
surface_reset_target();

finalSurf = _surf1;

