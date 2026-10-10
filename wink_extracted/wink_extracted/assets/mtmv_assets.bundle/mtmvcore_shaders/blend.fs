#ifdef GL_ES
precision highp float;
#else
#define highp
#define mediump
#define lowp
#endif

uniform sampler2D uTexture0;
uniform sampler2D uTexture1;
uniform float uOpacity;
uniform int uType;

varying vec2 vTexCoord0;
varying vec2 vTexCoord1;

vec4 normal(vec4 base, vec4 overlay)
{
    vec4 result;
    result.a = base.a + overlay.a - (base.a * overlay.a);
    if(result.a > 0.0001) {
        result.rgb = (base.rgb * base.a + overlay.rgb * overlay.a - base.rgb * base.a * overlay.a) / result.a;
    }
    else {
        result.rgb = base.rgb;
    }
    return result;
}
vec4 multiply(vec4 base, vec4 overlay)
{
    vec4 result;
    result.a = base.a + overlay.a - (base.a * overlay.a);
    if(result.a > 0.0001) {
        result.rgb = ((base.rgb * base.a + vec3(1.0 - base.a)) * (overlay.rgb + vec3(1.0 - overlay.a)) - 1.0) / result.a + 1.0;
    }
    else {
        result.rgb = base.rgb;
    }
    return result;
}
vec4 screen(vec4 base, vec4 overlay)
{
    vec4 result;
    result.a = base.a + overlay.a - (base.a * overlay.a);
    if(result.a > 0.0001) {
        result.rgb = (base.rgb * base.a + overlay.rgb - base.rgb * base.a * overlay.rgb) / result.a;
    }
    else {
        result.rgb = base.rgb;
    }
    return result;
}
vec4 overlay(vec4 base, vec4 overlay)
{
    vec4 result;
    result.a = base.a + overlay.a - (base.a * overlay.a);
    if(result.a > 0.0001) {
        if(base.r < 0.5) {
            result.r = 2.0 * overlay.r * base.r * base.a + overlay.r * (1.0 - base.a) + base.r * base.a * (1.0 - overlay.a);
        }
        else {
            result.r = overlay.r * (1.0 + base.a) + base.r * base.a * (1.0 + overlay.a) - 2.0 * base.r * base.a * overlay.r - base.a * overlay.a;
        }
        if(base.g < 0.5) {
            result.g = 2.0 * overlay.g * base.g * base.a + overlay.g * (1.0 - base.a) + base.g * base.a * (1.0 - overlay.a);
        }
        else {
            result.g = overlay.g * (1.0 + base.a) + base.g * base.a * (1.0 + overlay.a) - 2.0 * base.g * base.a * overlay.g - base.a * overlay.a;
        }
        if(base.b < 0.5) {
            result.b = 2.0 * overlay.b * base.b * base.a + overlay.b * (1.0 - base.a) + base.b * base.a * (1.0 - overlay.a);
        }
        else {
            result.b = overlay.b * (1.0 + base.a) + base.b * base.a * (1.0 + overlay.a) - 2.0 * base.b * base.a * overlay.b - base.a * overlay.a;
        }
        result.rgb /= result.a;
    }
    else {
        result.rgb = base.rgb;
    }
    return result;
}
vec4 darken(vec4 base, vec4 overlay)
{
    vec4 result;
    result.a = base.a + overlay.a - (base.a * overlay.a);
    if(result.a > 0.0001) {
        result.rgb = min(base.rgb * base.a * overlay.a, overlay.rgb * base.a) + overlay.rgb * (1.0 - base.a) + base.rgb * base.a * (1.0 - overlay.a);
    }
    else {
        result.rgb = base.rgb;
    }
    return result;
}
vec4 lighten(vec4 base, vec4 overlay)
{
    vec4 result;
    result.a = base.a + overlay.a - (base.a * overlay.a);
    if(result.a > 0.0001) {
        result.rgb = max(base.rgb * base.a * overlay.a, overlay.rgb * base.a) + overlay.rgb * (1.0 - base.a) + base.rgb * base.a * (1.0 - overlay.a);
    }
    else {
        result.rgb = base.rgb;
    }
    return result;
}


void main()
{
	vec4 baseLayer = texture2D(uTexture0, vTexCoord0);
	vec4 overlayLayer = texture2D(uTexture1, vTexCoord1);
	//overlay is alpha-premultiplied, so we need to multiply both color and alpha component
	overlayLayer *= uOpacity;
    if(uType == 0)
    {
        gl_FragColor = normal(baseLayer, overlayLayer);
    }else if(uType == 1){
        gl_FragColor = multiply(baseLayer, overlayLayer);
    }else if(uType == 2){
        gl_FragColor = screen(baseLayer, overlayLayer);
    }else if(uType == 3){
        gl_FragColor = overlay(baseLayer, overlayLayer);
    }else if(uType == 4){
        gl_FragColor = darken(baseLayer, overlayLayer);
    }else if(uType == 5){
        gl_FragColor = lighten(baseLayer, overlayLayer);
    }else{
        gl_FragColor = vec4(1.0, 1.0, 1.0, 1.0);
    }
}

