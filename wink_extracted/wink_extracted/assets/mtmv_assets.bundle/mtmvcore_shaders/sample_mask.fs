#ifdef GL_ES
precision highp float;
#else
#define highp
#define mediump
#define lowp
#endif
uniform sampler2D uTexture0;
uniform sampler2D uTexture1;
varying vec2 vTexCoord;
varying vec2 vMaskCoord;

void main()
{
    gl_FragColor = vec4(texture2D(uTexture0, vTexCoord).rgb * texture2D(uTexture1, vMaskCoord).a, texture2D(uTexture1, vMaskCoord).a * texture2D(uTexture0, vTexCoord).a);

//    gl_FragColor = texture2D(uTexture0, vTexCoord);
//    gl_FragColor.a += texture2D(uTexture1, vMaskCoord).a;
}
