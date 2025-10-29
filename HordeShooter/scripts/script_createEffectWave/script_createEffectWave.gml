function script_createEffectWave(xx, yy, durationSet, sizeInitial, sizeGrowFlat = 0, sizeGrowMult = 1, color = c_white, thickness = 3, thicknessChange = 0, alphaInner = 1, alphaOuter = 1, depthForce = -yy) {
	var _wave = instance_create_depth(xx, yy, depthForce, obj_wave);
	with(_wave) {
		radius = sizeInitial;
		increaseFlat = sizeGrowFlat;
		increaseMult = sizeGrowMult;
		
		duration = durationSet;
		
		width = thickness;
		widthChange = thicknessChange;

		innerAlpha = alphaInner;
		
		image_alpha = alphaOuter;
		image_blend = color;
	}
	
	return _wave;
}