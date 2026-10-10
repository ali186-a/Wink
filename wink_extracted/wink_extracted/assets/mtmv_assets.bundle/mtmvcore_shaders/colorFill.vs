attribute vec4 aPosition;
attribute vec2 aTexCoord0;
attribute vec4 aColor;
uniform mat4 uMVPMatrix;
varying vec2 vTexCoord;
varying vec4 vColor;
void main()
{
    gl_Position = uMVPMatrix * aPosition;
    vTexCoord = aTexCoord0;
    vColor = aColor;
}

