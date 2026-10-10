#ifdef GL_ES
#ifdef GL_FRAGMENT_PRECISION_HIGH
precision highp float;
#else
precision mediump float;
#endif
#endif

#define FACTOR_MAX 1.5
#define FACTOR_MIN 0.8

uniform sampler2D u_sourceTexture;
uniform sampler2D u_lightTexture;

uniform float u_max;
uniform float u_min;

varying vec2 v_Texcoord;

#include "blend.fs"

float toGray(vec3 rgb){
	return 0.299 * rgb.r + 0.587 * rgb.g + 0.114 * rgb.b;
}

void main()
{
    vec4 lightInfo = texture2D(u_lightTexture, v_Texcoord);
	vec4 bgColor = texture2D(u_sourceTexture, v_Texcoord);
	// vec4 faceMask = texture2D(u_faceTexture, v_Texcoord);

    float gray = toGray(bgColor.rgb);
    // float lightValue = toGray(lightInfo.rgb);
    float lightValue = smoothstep(0.0,1.0,lightInfo.r);
    vec3 factor = vec3(1.0);

    float lightFactor = lightValue * (u_max - u_min) + u_min;
    vec3 bgResult = lightFactor * bgColor.rgb;

    // vec3 bgResult = bgColor.rgb * vec3(vec3(1.0, 1.0, 1.0) + pow(lightInfo.rgb, vec3(1.0, 1.0, 1.0)));
    // bgResult = mix(bgColor.rgb, bgResult, lightInfo.a);

    gl_FragColor = vec4(bgResult, lightInfo.a);
    // gl_FragColor = vec4(vec3(lightFactor), 1.0);
    // gl_FragColor = vec4(faceMask.rgb, lightInfo.a);
}