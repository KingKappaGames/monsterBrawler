
varying vec2 v_vTexcoord;
varying vec4 v_vColour;

vec3 NormalBlend_Linear(vec3 n2) {
	vec3 n1 = vec3(0.5, 0.5, 1.0);
	n1 = n1*2.0-1.0;
	n2 = n2*2.0-1.0;
	return normalize(n1 + n2);
}

void main() {
	gl_FragColor = vec4(NormalBlend_Linear(texture2D(gm_BaseTexture, v_vTexcoord).xyz), v_vColour.a);
}
