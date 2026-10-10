attribute vec4 aPosition;
attribute vec2 aTexCoord0;

uniform mat4 uMVPMatrix;

varying vec2 vTexCoord0;
varying vec2 vTexCoord1;
void main()
{
    gl_Position = uMVPMatrix * aPosition;
    vTexCoord1 = aTexCoord0;
    vTexCoord0 = (gl_Position.xy + vec2(1.0, 1.0)) * 0.5;
}
