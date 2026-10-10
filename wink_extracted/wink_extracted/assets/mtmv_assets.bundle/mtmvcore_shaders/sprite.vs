///////////////////////////////////////////////////////////
// Attributes
attribute vec4 aPosition;
attribute vec2 aTexCoord0;
attribute vec4 aColor;

///////////////////////////////////////////////////////////
// Uniforms
uniform mat4 uMVPMatrix;

///////////////////////////////////////////////////////////
// Varyings
varying vec2 vTexCoord;
varying vec4 vColor;


void main()
{
    gl_Position = uMVPMatrix * aPosition;
    vTexCoord = aTexCoord0;
    vColor = aColor;
}

