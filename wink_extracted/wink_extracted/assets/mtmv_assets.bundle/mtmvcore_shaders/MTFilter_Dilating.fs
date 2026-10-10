#ifdef GL_ES
precision mediump  float;
#else
#define highp
#define mediump
#define lowp
#endif
uniform sampler2D uTexture0;
varying vec2 vTexCoord;
uniform float uWidth;
uniform float uHeight;
uniform float uPercent;

vec4 dilating()
{
    vec4 v = texture2D(uTexture0, vTexCoord);
    float percent = uPercent * 5.0;
    float xscale = percent / uWidth;
    float yscale = percent / uHeight;
    float delta_width = 1.0 / uWidth;
    float delta_height = 1.0 / uHeight;
    v = max(v, texture2D(uTexture0, vTexCoord + vec2(0, -yscale)));
    v = max(v, texture2D(uTexture0, vTexCoord + vec2(-xscale, 0)));
    v = max(v, texture2D(uTexture0, vTexCoord + vec2(xscale, 0)));
    v = max(v, texture2D(uTexture0, vTexCoord + vec2(0, yscale)));
    v = max(v, texture2D(uTexture0, vTexCoord + vec2(xscale, yscale)));
    v = max(v, texture2D(uTexture0, vTexCoord + vec2(xscale, -yscale)));
    v = max(v, texture2D(uTexture0, vTexCoord + vec2(-xscale, -yscale)));
    v = max(v, texture2D(uTexture0, vTexCoord + vec2(-xscale, yscale)));
    return v;
}
void main()
{
    gl_FragColor = dilating();
}
