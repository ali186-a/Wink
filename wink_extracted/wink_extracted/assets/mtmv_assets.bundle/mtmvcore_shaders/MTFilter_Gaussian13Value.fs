#ifdef GL_ES//for discriminate GLES & GL
#ifdef GL_FRAGMENT_PRECISION_HIGH
precision highp float;
#else
precision mediump float;
#endif
#else
#define highp
#define mediump
#define lowp
#endif
uniform sampler2D uTexture0;

const lowp int GAUSSIAN_SAMPLES = 13;

varying highp vec2 textureCoordinate;
varying highp vec2 blurCoordinates[GAUSSIAN_SAMPLES];
uniform int uAlphaPremultiplied;
void main()
{
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
    if (uAlphaPremultiplied == 0) {
        gl_FragColor = vec4(sum.rgb * sum.a, sum.a);
    }else {
        gl_FragColor = sum;
    }
}
