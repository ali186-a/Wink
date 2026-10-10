#ifdef GL_ES
precision highp float;
#else
#define highp
#define mediump
#define lowp
#endif
///////////////////////////////////////////////////////////
// Uniforms
uniform sampler2D uTexture0;

///////////////////////////////////////////////////////////
// Varyings
varying vec2 vTexCoord;
varying vec4 vColor;


void main()
{
    gl_FragColor = vColor * texture2D(uTexture0, vTexCoord);
}
