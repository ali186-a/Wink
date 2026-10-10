#ifdef GL_ES
precision highp float;
#else
#define highp
#define mediump
#define lowp
#endif
uniform sampler2D uTexture0;
varying vec2 vTexCoord;
//像素值
uniform float texelHeightOffset;
vec4 gauss()
{
    // Calculate the positions for the blur
    int multiplier = 0;
    vec2 blurStep;
    vec2 singleStepOffset = vec2(0.0, texelHeightOffset);
    vec2 blurCoordinates[13];
    for (int i = 0; i < 13; i++)
    {
        multiplier = (i - ((13 - 1) / 2));
        // Blur in x (horizontal)
        blurStep = float(multiplier) * singleStepOffset;
        blurCoordinates[i] = vTexCoord + blurStep;
    }
    
    vec4 src = texture2D(uTexture0, blurCoordinates[6]);
    //13x13
    highp vec4 sum = vec4(0.0);
    sum += texture2D(uTexture0, blurCoordinates[0]) * 0.046118;
    sum += texture2D(uTexture0, blurCoordinates[1]) * 0.058552;
    sum += texture2D(uTexture0, blurCoordinates[2]) * 0.071181;
    sum += texture2D(uTexture0, blurCoordinates[3]) * 0.082860;
    sum += texture2D(uTexture0, blurCoordinates[4]) * 0.092356;
    sum += texture2D(uTexture0, blurCoordinates[5]) * 0.098568;
    sum += texture2D(uTexture0, blurCoordinates[6]) * 0.100731;
    sum += texture2D(uTexture0, blurCoordinates[7]) * 0.098568;
    sum += texture2D(uTexture0, blurCoordinates[8]) * 0.092356;
    sum += texture2D(uTexture0, blurCoordinates[9]) * 0.082860;
    sum += texture2D(uTexture0, blurCoordinates[10]) * 0.071181;
    sum += texture2D(uTexture0, blurCoordinates[11]) * 0.058552;
    sum += texture2D(uTexture0, blurCoordinates[12]) * 0.046118;
    return sum;
}

void main()
{
    gl_FragColor = gauss();
}
