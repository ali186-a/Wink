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

attribute vec2 inputTextureCoordinate;

varying vec2 textureCoordinate;

void main()
{
    textureCoordinate = inputTextureCoordinate.xy;
    gl_Position  = vec4(inputTextureCoordinate.x * 2.0 - 1.0,(inputTextureCoordinate.y*2.0 - 1.0), 0.0, 1.0);
}
