#ifdef GL_ES
precision highp float;
#else
#define highp
#define mediump
#define lowp
#endif
uniform sampler2D uTexture0;
uniform vec2 uInverseSize;
uniform int uRadius;

varying vec2 vTexCoord;

void main()
{
    gl_FragColor = texture2D(uTexture0, vTexCoord);
    float alpha = gl_FragColor.a;
    alpha = min(alpha, texture2D(uTexture0, vTexCoord + 0.3 * uInverseSize).a);
    alpha = min(alpha, texture2D(uTexture0, vTexCoord - 0.3 * uInverseSize).a);

    if(uRadius > 1)
    {
        alpha = min(alpha, texture2D(uTexture0, vTexCoord + 0.6 * uInverseSize).a);
        alpha = min(alpha, texture2D(uTexture0, vTexCoord - 0.6 * uInverseSize).a);
    }
    if(uRadius > 2)
    {
        alpha = min(alpha, texture2D(uTexture0, vTexCoord + 0.9 * uInverseSize).a);
        alpha = min(alpha, texture2D(uTexture0, vTexCoord - 0.9 * uInverseSize).a);
    }
    if(uRadius > 3)
    {
        alpha = min(alpha, texture2D(uTexture0, vTexCoord + 1.2 * uInverseSize).a);
        alpha = min(alpha, texture2D(uTexture0, vTexCoord - 1.2 * uInverseSize).a);
    }
    if(uRadius > 4)
    {
        alpha = min(alpha, texture2D(uTexture0, vTexCoord + 1.5 * uInverseSize).a);
        alpha = min(alpha, texture2D(uTexture0, vTexCoord - 1.5 * uInverseSize).a);
    }
    if(uRadius > 5)
    {
        alpha = min(alpha, texture2D(uTexture0, vTexCoord + 1.8 * uInverseSize).a);
        alpha = min(alpha, texture2D(uTexture0, vTexCoord - 1.8 * uInverseSize).a);
    }

    gl_FragColor.a = alpha;
}
