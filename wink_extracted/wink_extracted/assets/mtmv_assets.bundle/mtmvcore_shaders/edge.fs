#ifdef GL_ES
precision highp float;
#else
#define highp
#define mediump
#define lowp
#endif

uniform sampler2D uTexture0;
uniform vec2 uInverseSize;

varying vec2 vTexCoord;

void main()
{
    float alpha = texture2D(uTexture0, vTexCoord).a;
//    float diff = texture2D(uTexture0, vTexCoord + vec2(-1.0, 0.0) * uInverseSize.x).a - alpha;
//    diff = max(diff, texture2D(uTexture0, vTexCoord + vec2(1.0, 0.0) * uInverseSize.x).a - alpha);
//    diff = max(diff, texture2D(uTexture0, vTexCoord + vec2(0.0, -1.0) * uInverseSize.y).a - alpha);
//    diff = max(diff, texture2D(uTexture0, vTexCoord + vec2(0.0, 1.0) * uInverseSize.y).a - alpha);
        float diff = alpha - texture2D(uTexture0, vTexCoord + vec2(-1.0, 0.0) * uInverseSize.x).a;
        diff = max(diff, alpha - texture2D(uTexture0, vTexCoord + vec2(1.0, 0.0) * uInverseSize.x).a);
        diff = max(diff, alpha - texture2D(uTexture0, vTexCoord + vec2(0.0, -1.0) * uInverseSize.y).a);
        diff = max(diff, alpha - texture2D(uTexture0, vTexCoord + vec2(0.0, 1.0) * uInverseSize.y).a);
    gl_FragColor = vec4(diff);
} 

