#ifdef GL_ES
precision highp float;
#else
#define highp
#define mediump
#define lowp
#endif
uniform sampler2D uTexture0;
varying vec2 vTexCoord;
varying vec4 vColor;

void main()
{
    gl_FragColor = vColor;
}
