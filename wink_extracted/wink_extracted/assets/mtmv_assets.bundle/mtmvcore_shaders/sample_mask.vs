attribute vec4 aPosition;
attribute vec2 aTexCoord0;

uniform mat4 uMVPMatrix;

varying vec2 vTexCoord;
varying vec2 vMaskCoord;
void main()
{
    gl_Position = uMVPMatrix * aPosition;
    vTexCoord = aTexCoord0;
    vMaskCoord = (gl_Position.xy + vec2(1.0, 1.0)) * 0.5;
}
