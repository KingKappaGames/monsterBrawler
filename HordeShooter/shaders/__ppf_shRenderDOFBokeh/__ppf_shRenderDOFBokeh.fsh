
/*------------------------------------------------------------------
You cannot redistribute this pixel shader source code anywhere.
Only compiled binary executables. Don't remove this notice, please.
Copyright (C) 2025 Mozart Junior (FoxyOfJungle). Kazan Games Ltd.
Website: https://foxyofjungle.itch.io/ | Discord: @foxyofjungle
-------------------------------------------------------------------*/

varying vec2 v_vTexcoord;

// quality (low number = more performance)
#ifdef _YY_HLSL11_
#define ITERATIONS 150.0 // windows
#else
#define ITERATIONS 75.0 // others (android, operagx...)
#endif

const float Tau = 6.28318;
const float Golden_Angle = 2.39996323;

// >> uniforms
uniform vec2 u_texelSize;

uniform float u_focusDistance;
uniform float u_focusRange;
uniform float u_focusWidth;
uniform float u_focusNear;
uniform float u_focusFar;

uniform float u_bokehRadius;
uniform float u_bokehIntensity;

uniform sampler2D u_zDepthTexture;
uniform float u_zDepthLinearize;
uniform vec2 u_zDepthNearFar;

uniform float u_bokehBladesAperture;
uniform float u_bokehBladesAngle;
uniform float u_debug;

// Based on DOF by Dennis Gustafsson.
// Improved and implemented for GameMaker by Mozart Junior

// >> dependencies
uniform float u_lensDistortionEnable;
uniform float u_lensDistortionAmount;
vec2 ApplyLensDistortionUV(vec2 uv, float intensity) {
	vec2 uvCenter = vec2(0.5);
	vec2 dir = (uv - uvCenter);
	float polar = atan(dir.y, dir.x);
	float radius = length(dir);
	radius *= (1.0 + pow(radius, 2.0) * u_lensDistortionAmount * intensity);
	uv = uvCenter + radius * vec2(cos(polar), sin(polar));
	return uv;
}

#region Common

float Saturate(float x) {
	return clamp(x, 0.0, 1.0);
}

vec3 Blend(vec3 source, vec3 dest) {
	return source + dest - source * dest;
}

float GetLuminance(vec3 color) {
	return dot(color, vec3(0.299, 0.587, 0.114));
}

vec3 uncharted2Tonemap(vec3 x) {
	float A = 0.15;
	float B = 0.50;
	float C = 0.10;
	float D = 0.20;
	float E = 0.02;
	float F = 0.30;
	float W = 11.2;
	return ((x * (A * x + C * B) + D * E) / (x * (A * x + B) + D * F)) - E / F;
}
vec3 tonemap_uncharted2(vec3 color) {
	float W = 11.2;
	float exposureBias = 8.0;
	vec3 curr = uncharted2Tonemap(exposureBias * color);
	vec3 whiteScale = 1.0 / uncharted2Tonemap(vec3(W));
	return curr * whiteScale;
}

#endregion

//const float u_zDepthContrast = 100.0;
float getDepth(sampler2D texture, vec2 uv) {
	float depth = 0.0;
	if (u_zDepthLinearize > 0.5) {
		float d = texture2D(texture, uv).r;
		float n = u_zDepthNearFar.x;
		float f = u_zDepthNearFar.y;
		depth = (2.0 * n) / (f + n - d * (f - n));
	} else {
		depth = texture2D(texture, uv).r;
	}
	//depth = (depth - 0.5) * u_zDepthContrast + 0.5;
	return depth;
}
float getCoC(float depth) {
	float dif = ((1.0 / u_focusDistance) - (1.0 / depth)+0.5) * u_focusRange;
	float coc = clamp(sign(dif)*smoothstep(u_focusWidth, 1.0, abs(dif)), -u_focusNear, u_focusFar);
	return abs(coc) * u_bokehRadius;
}
vec2 bokehShape(float i, mat2 angle, float aperture) {
	float s = cos(aperture) / cos(mod(i, 2.0*aperture) - aperture);
	return vec2(cos(i), sin(i)) * s * angle;
}
//uniform sampler2D u_bokehTexture;
//vec2 sampleShape(float i, float reciprocal, sampler2D bokehSprite) {
//	return vec2(cos(i+sin(i)), sin(i+cos(i))) * (texture2D(bokehSprite, vec2(reciprocal, 0.5)).rg*2.0-1.0);
//}
////vec2 offset = sampleShape(ang, ang/(Golden_Angle*ITERATIONS), u_bokehTexture) * u_texelSize * radius;

void main() {
	vec2 uv = v_vTexcoord;
	
	// lens distortion (if needed)
	vec2 uvDepth = uv;
	if (u_lensDistortionEnable > 0.5) uvDepth = ApplyLensDistortionUV(uv, 1.0);
	
	// dof
	mat2 shapeAng = mat2(cos(u_bokehBladesAngle), -sin(u_bokehBladesAngle), sin(u_bokehBladesAngle), cos(u_bokehBladesAngle));
	
	float centerDepth = getDepth(u_zDepthTexture, uvDepth);
	float centerSize = getCoC(centerDepth);
	
	float total = 1.0;
	float radius = 1.0;
	vec4 blur = texture2D(gm_BaseTexture, uv); // comment this to get black alpha
	vec4 light = vec4(0.0);
	for(float ang = 0.0; ang < (Golden_Angle*ITERATIONS); ang += Golden_Angle) {
		vec2 offset = bokehShape(ang, shapeAng, u_bokehBladesAperture) * u_texelSize * radius;
		vec4 tex = texture2D(gm_BaseTexture, uv + offset);
		float depth = getDepth(u_zDepthTexture, uvDepth + offset);
		float coc = getCoC(depth);
		if (depth > centerDepth) coc = clamp(coc, 0.0, centerSize*2.0);
		float mid = smoothstep(radius-0.5, radius+0.5, coc);
		light += pow(tex, vec4(vec3(8.0), 1.0)) * mid;
		blur += mix(blur/total, tex, mid);
		total += 1.0;
		radius += 1.0/radius;
	}
	vec4 bokehCol = blur / total;
	
	vec4 lightsCol = (light*u_bokehIntensity) / total;
	lightsCol.rgb = uncharted2Tonemap(lightsCol.rgb);
	bokehCol.rgb = Blend(bokehCol.rgb, lightsCol.rgb);
	
	if (u_debug > 0.5) {
		float sceneLum = GetLuminance(bokehCol.rgb);
		vec3 debugCol = mix(vec3(0.75, 0.0, 0.0)+sceneLum, vec3(sceneLum), Saturate(centerSize/u_bokehRadius));
		//debugCol *= GetLuminance(bokehCol.rgb) + 0.5;
		bokehCol.rgb = debugCol;
	}
	//bokehCol.a = 1.0;
	gl_FragColor = bokehCol;
	//gl_FragColor = vec4(vec3(getDepth(u_zDepthTexture, uvDepth)), 1.0);
	//gl_FragColor = vec4(vec3(texture2D(u_bokehTexture, uvDepth).r), 1.0);
}
