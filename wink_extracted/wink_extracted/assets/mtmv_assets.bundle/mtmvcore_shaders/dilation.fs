#ifdef GL_ES
precision highp float;
#else
#define highp
#define mediump
#define lowp
#endif

uniform sampler2D uTexture0;
uniform vec2 uInverseSize;
uniform int uRADIUS;

varying vec2 vTexCoord;

void main()
{
    float alpha = texture2D(uTexture0, vTexCoord).a;
    alpha = max(alpha, texture2D(uTexture0, vTexCoord + 1.0 * uInverseSize).a);
    alpha = max(alpha, texture2D(uTexture0, vTexCoord - 1.0 * uInverseSize).a);

    if(uRADIUS > 1)
    {
        alpha = max(alpha, texture2D(uTexture0, vTexCoord + 2.0 * uInverseSize).a);
        alpha = max(alpha, texture2D(uTexture0, vTexCoord - 2.0 * uInverseSize).a);
    }
    if(uRADIUS > 2)
    {
        alpha = max(alpha, texture2D(uTexture0, vTexCoord + 3.0 * uInverseSize).a);
        alpha = max(alpha, texture2D(uTexture0, vTexCoord - 3.0 * uInverseSize).a);
    }
    if(uRADIUS > 3)
    {
        alpha = max(alpha, texture2D(uTexture0, vTexCoord + 4.0 * uInverseSize).a);
        alpha = max(alpha, texture2D(uTexture0, vTexCoord - 4.0 * uInverseSize).a);
    }
    if(uRADIUS > 4)
    {
        alpha = max(alpha, texture2D(uTexture0, vTexCoord + 5.0 * uInverseSize).a);
        alpha = max(alpha, texture2D(uTexture0, vTexCoord - 5.0 * uInverseSize).a);
    }

    gl_FragColor = vec4(alpha, alpha, alpha, alpha);
}
