#ifdef GL_ES
precision highp float;
#else
#define highp
#define mediump
#define lowp
#endif

uniform sampler2D uTexture0;
uniform float uThreshold;

varying vec2 vTexCoord;

void main()
{
    gl_FragColor = texture2D(uTexture0, vTexCoord);
    gl_FragColor = step(vec4(uThreshold), gl_FragColor);
}
