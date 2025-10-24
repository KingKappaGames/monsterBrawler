varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform float strength;

void main() {
	vec4 originalPixel = texture2D(gm_BaseTexture, v_vTexcoord) * v_vColour;
	gl_FragColor = vec4(originalPixel.rgb * (strength + 1.0), originalPixel.a); // push to black if burning to simulate, idk, the light flickering washing out the colors?
}
