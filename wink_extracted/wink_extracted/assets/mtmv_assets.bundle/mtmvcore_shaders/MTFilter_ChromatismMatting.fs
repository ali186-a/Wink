#ifdef GL_ES
precision highp float;
#else
#define highp
#define mediump
#define lowp
#endif

varying  vec2 vTexCoord;

uniform sampler2D uTexture0;
uniform vec3 uMattingColorLab;
uniform vec4 uMattingColorRgba;
uniform float uIntensity;
uniform float uPercent;
uniform int uAlphaPremultiplied;

//RGB2Lab Lab2RGB
const float param_13 = 1.0 / 3.0;
const float param_16116 = 16.0 / 116.0;
const float Xn = 0.950456;
const float Yn = 1.0;
const float Zn = 1.088754;

float gamma(float x)
{
    return x>0.04045?pow((x+0.055)/1.055,2.4):(x/12.92);
}

vec3 RGB2XYZ(float R, float G, float B) {
    vec3 xyz;
    float RR = gamma(R/255.0);
    float GG = gamma(G/255.0);
    float BB = gamma(B/255.0);

    xyz.x = 0.4124564 * RR + 0.3575761 * GG + 0.1804375 * BB;
    xyz.y = 0.2126729 * RR + 0.7151522 * GG + 0.0721750 * BB;
    xyz.z = 0.0193339 * RR + 0.1191920 * GG + 0.9503041 * BB;
    return xyz;
}

vec3 XYZ2Lab(float X, float Y, float Z) {
    vec3 lab;
    float fX, fY, fZ;

    X /= (Xn);
    Y /= (Yn);
    Z /= (Zn);

    if (Y > 0.008856)
        fY = pow(Y, param_13);
    else
        fY = 7.787 * Y + param_16116;

    if (X > 0.008856)
        fX = pow(X, param_13);
    else
        fX = 7.787 * X + param_16116;

    if (Z > 0.008856)
        fZ = pow(Z, param_13);
    else
        fZ = 7.787 * Z + param_16116;

    lab.x = 116.0 * fY - 16.0;
    lab.x = lab.x > 0.0 ? lab.x : 0.0;
    lab.y = 500.0 * (fX - fY);
    lab.z = 200.0 * (fY - fZ);
    return lab;
}

void main(void)
{
    vec4 origin = texture2D(uTexture0, vTexCoord).rgba;

    vec3 originLab;
    vec3 originXyz;
    originXyz = RGB2XYZ(origin.x * 255.0,origin.y * 255.0,origin.z * 255.0);
    originLab = XYZ2Lab(originXyz.x,originXyz.y,originXyz.z);

    float e = sqrt((uMattingColorLab.x - originLab.x) * (uMattingColorLab.x - originLab.x) + (uMattingColorLab.y - originLab.y) * (uMattingColorLab.y - originLab.y) + (uMattingColorLab.z - originLab.z) * (uMattingColorLab.z - originLab.z));

    if (e < uIntensity) {
        origin.r = origin.r - uMattingColorRgba.r;
        origin.g = origin.g - uMattingColorRgba.g;
        origin.b = origin.b - uMattingColorRgba.b;
        origin.a = origin.a - uMattingColorRgba.a;
        if (uPercent > 0.0 && e - (1.0 - uPercent) * uIntensity > 0.0) {
            origin.r = origin.r + uMattingColorRgba.r * (e - (1.0 - uPercent) * uIntensity) / (uPercent * uIntensity);
            origin.g = origin.g + uMattingColorRgba.g * (e - (1.0 - uPercent) * uIntensity) / (uPercent * uIntensity);
            origin.b = origin.b + uMattingColorRgba.b * (e - (1.0 - uPercent) * uIntensity) / (uPercent * uIntensity);
            origin.a = origin.a + uMattingColorRgba.a * (e - (1.0 - uPercent) * uIntensity) / (uPercent * uIntensity);
        }
//        float uIntensityPer = 0.6 * uIntensity / 200.0;//控制模糊补充颜色范围
//        if (uPercent > 0.0 && e - (1.0 - uIntensityPer * uPercent) * uIntensity > 0.0) {
//            float mattingColorRgbaPer = 1.3 * (e - (1.0 - uPercent) * uIntensity) / (uPercent * uIntensity);//控制模糊补色强度
//            if (mattingColorRgbaPer > 1.0) {
//                mattingColorRgbaPer = 1.0;
//            }
//            origin.r = origin.r + uMattingColorRgba.r * mattingColorRgbaPer;
//            origin.g = origin.g + uMattingColorRgba.g * mattingColorRgbaPer;
//            origin.b = origin.b + uMattingColorRgba.b * mattingColorRgbaPer;
//            origin.a = origin.a + uMattingColorRgba.a * mattingColorRgbaPer;
//        }
    }
    if (uAlphaPremultiplied == 1) {
        gl_FragColor = vec4(origin.rgb * origin.a, origin.a);
    } else {
        gl_FragColor = origin;
    }
}
