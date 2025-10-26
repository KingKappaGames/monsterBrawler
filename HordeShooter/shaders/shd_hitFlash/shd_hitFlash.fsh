varying vec2 v_vTexcoord;
varying vec4 v_vColour;

void main()
{
	if(texture2D( gm_BaseTexture, v_vTexcoord ).a > 0.0) {
    	gl_FragColor = vec4(1.0, 1.0, 1.0, 1.0);
	} else {
		discard;
	}
}
