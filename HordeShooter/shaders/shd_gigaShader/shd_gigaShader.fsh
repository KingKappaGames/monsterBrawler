varying vec2 v_vTexcoord;
varying vec4 v_vColour;


uniform float u_GrayscaleAmount;


uniform float height; // the inverse height of the clipping material normalized to 0-1, so snow thats 1 foot up on a 6 foot person would have a height of 1/6 aka .17 flipped to .83 because shaders are top down, so you have to pass 1 - (materialHeight / characterHeight)
uniform float wrapCircleNormalizedRadius; // normalized (0-1) width of a potential circle of occlusion around the sprite, so like, a wrap of .5 would mean that a rectangle would have a perfect circle of raising snow or whatever on the edges up to 180 and 360 degrees, a half circle facing up, more range means flatter wrap. Less range means... Sin curves for wrap?
uniform vec4 uvs;
uniform bool burning;


void main() {	
	vec4 originalPixel = texture2D(gm_BaseTexture, v_vTexcoord);
	
	if(originalPixel.a < .01) { discard; } // dump empty pixels for both speed and because those pixels WILL screw up light rendering and stuff that requires alpha testing (we're in a shader, screwing alpha testing is our thing)
	
	if(height != 1.0) {
		float heightRange = uvs.w - uvs.y;
		float pixelHeight = ((v_vTexcoord.y - uvs.y) / heightRange); // the 0-1 y value of this pixel in the sprite
	
		if(pixelHeight > height) { // range from beginning to end of uv range relative to absolute
			discard; // if is below clipping area remove pixel (flat clip)
		} else if(wrapCircleNormalizedRadius != 0.0) { // not under the flat line (0 means pass, aka flat line no curved occlusion)
			float xRelative = ((v_vTexcoord.x - uvs.x) / (uvs.z - uvs.x)) - .5; // -.5 to .5 across this sprite
			float wrapY = (sin((xRelative / wrapCircleNormalizedRadius) * 1.57 - 1.57) / 2.0 + .5) * heightRange; // scale to y size instead of just x off = y off..?
			if(pixelHeight > height - wrapY) {
				discard; // clear pixels around the round edges of these things, maybe doesn't make sense in all cases but works here... (most creatures are round and thus will have rounded height blocking)
			}
		} // if you pass this point then you're drawing, the ones discarded don't reach here
	}
	
	if(u_GrayscaleAmount != 0.0) {
		vec4 originalColor = v_vColour * originalPixel;
  
		float luminance = dot(originalColor.rgb, vec3(0.299, 0.587, 0.114));
  
		vec4 grayscaleColor = vec4(luminance, luminance, luminance, originalColor.a);
 
		gl_FragColor = mix(originalColor, grayscaleColor, u_GrayscaleAmount);	
	} else if(burning) {
		gl_FragColor = vec4(mix(v_vColour * originalPixel, vec4(0., 0., 0., 1.0), .85)); // push to black if burning to simulate, idk, the light flickering washing out the colors?
	} else {
		gl_FragColor = v_vColour * originalPixel;
	}
}
