
/*=================================================================================================
	These functions are independent, so if you delete them from the asset, it will not interfere
	with other features of PPFX.
=================================================================================================*/

// Feather ignore all

/// @desc Create normal map renderer. This will be responsible for drawing objects with normal map (like shockwaves) on a surface and sending it to the PPFX_Renderer() instance.
/// @param {Struct} renderer The returned variable by "new PPFX_Renderer()".
/// @param {Bool} isWorldSpace If true, things will be drawn in world/room space (using current camera projection). Note that this does not influence the internal surface size. If false, you can for example, call the .Render() in the GUI event.
/// @param {String,Macro} effect The effect name or macro. Example: FF_SHOCKWAVES or FF_DISPLACEMAP.
/// @param {String,Macro} effectTextureParam The effect texture parameter name or macro. Example: PP_SHOCKWAVES_TEXTURE or PP_DISPLACEMAP_TEXTURE.
/// @param {Bool} normalObject Object (preferably a parent object) that will be used to draw your instances on the surface.
function PPFX_NormalmapRenderer(_renderer, _isWorldSpace=true, _effect=FF_SHOCKWAVES, _effectTextureParam=PP_SHOCKWAVES_TEXTURE, _normalObject=__ppf_objNormalEffect) constructor {
	__ppf_trace($"Normal map renderer created", 3);
	
	// Base
	__ppfxRenderer = _renderer;
	__isWorldSpace = _isWorldSpace;
	__effect = _effect;
	__effectTextureParameter = _effectTextureParam;
	__surface = -1;
	__surfaceWidth = 0;
	__surfaceHeight = 0;
	__renderResolution = 1;
	__oldRenderResolution = __renderResolution;
	__oldInputSurfaceWidth = 0;
	__oldInputSurfaceHeight = 0;
	__isHighPrecision = false;
	
	// Misc
	__normalmapObject = _normalObject;
	__allowRendering = true;
	__destroyed = false;
	
	#region Private Methods
		/// @ignore
		static __cleanSurface = function() {
			if (surface_exists(__surface)) surface_free(__surface);
		}
	#endregion
	
	#region Public Methods
	
	/// @desc Destroy shockwave system, freeing it from memory.
	static Destroy = function() {
		__cleanSurface();
		__destroyed = true;
	}
	
	/// @method SetRenderResolution(resolution)
	/// @desc This function modifies the final rendering resolution of the shockwaves surface, based on a percentage (0 to 1).
	/// @param {real} resolution Value from 0 to 1. Useful for pixelated effects. Default scale is 1.
	static SetRenderResolution = function(_resolution=1) {
		__renderResolution = clamp(_resolution, 0.01, 1);
		return self;
	}
	
	/// @desc Defines whether shockwaves will have greater precision, paying for a little more memory usage by the surface.
	/// @method SetHighPrecisionEnable(enable)
	/// @param {real} enable Will be either true (enabled, the default value) or false (disabled). This will toggle if nothing or -1 is entered.
	/// @returns {undefined}
	static SetHighPrecisionEnable = function(_enable=-1) {
		if (_enable == -1) {
			__isHighPrecision = !__isHighPrecision;
		} else {
			__isHighPrecision = _enable;
		}
		return self;
	}
	
	/// @method SetObject(object)
	/// @desc Defines which object is the parent of shockwaves, the system will draw any instance of it, when created.
	/// @param {Asset.GMObject} object Distortion object that will be used to call the Draw Event. Example: [obj_shockwave].
	static SetObject = function(_object) {
		__normalmapObject = _object;
		return self;
	}
	
	/// @method RemoveObject(object)
	/// @desc This function removes a previously setted normal map object.
	/// @param {Asset.GMObject} object The normal map object.
	static RemoveObject = function(_object) {
		__normalmapObject = undefined;
		return self;
	}
	
	/// @desc Get the surface used in the normal map renderer. Used for debugging generally.
	/// @method GetSurface()
	/// @param {Struct} system_index description
	static GetSurface = function() {
		return __surface;
	}
	
	/// @desc Returns the rendering resolution percentage (0 to 1).
	/// @method GetRenderResolution()
	/// @returns {real} Normalized size.
	static GetRenderResolution = function() {
		return __renderResolution;
	}
	
	#endregion
	
	#region Render
	
	/// @method Render(renderer)
	/// @desc Renderize normal map surface, using the camera view projection (if world-space). Please note that this will not draw the surface, only generate the content.
	/// Basically this function will call the Draw Event of the objects in the array and draw them on the surface.
	/// This surface will be sent to the Post-processing renderer automatically, for it to draw the normal maps.
	static Render = function(_camera) {
		if (__destroyed) exit;
		
		// Checks
		if (__ppfxRenderer == undefined) {
			if (__allowRendering) {
				__allowRendering = false;
				__ppf_trace("Normalmap Renderer: Post-processing renderer does not exist. Unable to proceed", 1);
			}
			exit;
		}
		
		// do nothing if the ppfx renderer's surface doesn't exists
		if (!__ppfxRenderer.__allowRendering || __normalmapObject == undefined) exit;
		
		// verify if there are any shockwaves instances, if not, disable everything (for performance)
		if (instance_number(__normalmapObject) <= 0) {
			if (__allowRendering) {
				__allowRendering = false;
				__ppfxRenderer.SetEffectEnable(__effect, false);
				__cleanSurface();
			}
			exit;
		} else {
			if (!__allowRendering) {
				__allowRendering = true;
				__ppfxRenderer.SetEffectEnable(__effect, true);
			}
		}
		
		// Get current input surface and create surface with the same size
		var _inputSurface = surface_get_target();
		if (!surface_exists(_inputSurface)) exit;
		var _inputSurfaceWidth = surface_get_width(_inputSurface);
		var _inputSurfaceHeight = surface_get_height(_inputSurface);
		if (_inputSurfaceWidth <= 0 || _inputSurfaceHeight <= 0) exit;
		
		// if different resolution, delete stuff to be updated
		if (_inputSurfaceWidth != __oldInputSurfaceWidth || _inputSurfaceHeight != __oldInputSurfaceHeight || __renderResolution != __oldRenderResolution) {
			__oldInputSurfaceWidth = _inputSurfaceWidth;
			__oldInputSurfaceHeight = _inputSurfaceHeight;
			__oldRenderResolution = __renderResolution;
			__cleanSurface();
			__surfaceWidth = _inputSurfaceWidth * __renderResolution;
			__surfaceHeight = _inputSurfaceHeight * __renderResolution;
			__surfaceWidth -= frac(__surfaceWidth);
			__surfaceHeight -= frac(__surfaceHeight);
		}
		
		// Generate distortion surface
		if (!surface_exists(__surface)) {
			var _isFormatSupported = surface_format_is_supported(surface_rgba16float);
			if (!_isFormatSupported) {
				__ppf_trace("NormalmapRenderer: High precision mode not supported on current platform", 1);
			}
			__surface = surface_create(__surfaceWidth, __surfaceHeight, (_isFormatSupported && __isHighPrecision) ? surface_rgba16float : surface_rgba8unorm);
			__ppfxRenderer.SetEffectParameter(__effect, __effectTextureParameter, surface_get_texture(__surface));
		}
		surface_set_target(__surface, _inputSurface);
			draw_clear_ext(make_color_rgb(128, 128, 255), 1);
			gpu_push_state();
			gpu_set_zwriteenable(false);
			gpu_set_tex_filter(true);
			gpu_set_tex_repeat(false);
			gpu_set_blendmode(bm_add);
			if (__isWorldSpace) camera_apply(_camera);
			shader_set(__ppf_shBlendNormals);
			// draw normal map sprites to distort screen
			var _oldDepth = gpu_get_depth();
			with(__normalmapObject) {
				gpu_set_depth(depth);
				event_perform(ev_draw, 0);
			}
			gpu_set_depth(_oldDepth);
			shader_reset();
			gpu_pop_state();
		surface_reset_target();
	}
	
	#endregion
}

/// @desc Create a new shockwave instance. Note: this is just to make it easier, you can use instance_create_layer directly too.
/// @param {Real} x The horizontal X position the object will be created at.
/// @param {Real} y The vertical Y position the object will be created at.
/// @param {String|Id.Layer} layer_id The layer ID (or name) to assign the created instance to.
/// @param {Real} index The shockwave shape (image_index).
/// @param {Real} scale The shockwave size (default: 1).
/// @param {Real} incrementSpeed The shockwave increment speed. Use a value less than 1.
/// @param {Asset.GMObject} object The object to be created (shockwave object).
/// @param {Asset.GMAnimCurve} anim_curve The animation curve to be used by shockwave object. It must contain the parameters "scale" and "alpha", which range from 0 to 1.
/// @returns {Id.Instance} Instance id.
function shockwave_instance_create(_x, _y, _layerId, _index=0, _scale=1, _incrementSpeed=0.03, _object=__ppf_objShockwave, _animCurve=__ppf_acShockwave) {
	var _inst = instance_create_layer(_x, _y, _layerId, _object, {
		visible : false,
		image_index : _index,
		scale : _scale,
		spd : _incrementSpeed,
		animCurve : _animCurve
	});
	return _inst;
}
