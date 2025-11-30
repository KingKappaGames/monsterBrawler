
/*-------------------------------------------------------------------------------------------------
	These functions are independent, so if you delete them from the asset, nothing will happen.
-------------------------------------------------------------------------------------------------*/

// Feather ignore all
/// @desc Uses the final image texture from the post-processing renderer as the texture for what to draw next. You MUST call ppfx_area_mask_end() when you are done drawing masks.
/// If for example you draw a sprite after calling this function, the alpha channel of the sprite will be taken into account, but using the PPFX texture.
/// You can draw multiple things after calling this function, using the same renderer texture.
/// You can call this function multiple times for the same renderer.
/// @param {Struct} renderer The returned variable by PPFX_Renderer().
function ppfx_area_mask_begin(_renderer) {
	static u_renderTexture = shader_get_sampler_index(__ppf_shAreaMask, "u_renderTexture");
	static u_renderTexPosRes = shader_get_uniform(__ppf_shAreaMask, "u_renderTexPosRes");
	if (!__ppf_renderer_exists(_renderer)) exit;
	var _surf = _renderer.GetRenderSurface();
	if (surface_exists(_surf)) {
		shader_set(__ppf_shAreaMask);
		texture_set_stage(u_renderTexture, surface_get_texture(_surf));
		shader_set_uniform_f(u_renderTexPosRes, _renderer.__drawX, _renderer.__drawY, _renderer.__drawW, _renderer.__drawH);
	}
}

/// @desc This should be called after all ppfx_area_mask_begin() calls.
function ppfx_area_mask_end() {
	shader_reset();
}
