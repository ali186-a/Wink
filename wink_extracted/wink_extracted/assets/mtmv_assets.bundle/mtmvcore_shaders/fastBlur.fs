#ifdef GL_ES
precision highp float;
#else
#define highp
#define mediump
#define lowp
#endif
uniform sampler2D uTexture0;
varying vec2 vTexCoord;
uniform vec2 uStep;
uniform int uRadius;

void main()
{
    if(uRadius == 4)
    {
        gl_FragColor = texture2D(uTexture0, vTexCoord) * 0.2270270270;
        gl_FragColor += texture2D(uTexture0, vTexCoord + vec2(-1.3846153846) * uStep) * 0.3162162162;
        gl_FragColor += texture2D(uTexture0, vTexCoord + vec2(1.3846153846) * uStep) * 0.3162162162;
        gl_FragColor += texture2D(uTexture0, vTexCoord + vec2(-3.2307692308) * uStep) * 0.0702702703;
        gl_FragColor += texture2D(uTexture0, vTexCoord + vec2(3.2307692308) * uStep) * 0.0702702703;
    }
    else if(uRadius == 6)
    {
        gl_FragColor = texture2D(uTexture0, vTexCoord) * 0.1964825501511404;
        gl_FragColor += texture2D(uTexture0, vTexCoord + vec2(-1.411764705882353) * uStep) * 0.2969069646728344;
        gl_FragColor += texture2D(uTexture0, vTexCoord + vec2(1.411764705882353) * uStep) * 0.2969069646728344;
        gl_FragColor += texture2D(uTexture0, vTexCoord + vec2(-3.2941176470588234) * uStep) * 0.09447039785044732;
        gl_FragColor += texture2D(uTexture0, vTexCoord + vec2(3.2941176470588234) * uStep) * 0.09447039785044732;
        gl_FragColor += texture2D(uTexture0, vTexCoord + vec2(-5.176470588235294) * uStep) * 0.010381362401148057;
        gl_FragColor += texture2D(uTexture0, vTexCoord + vec2(5.176470588235294) * uStep) * 0.010381362401148057;
    }
    else if(uRadius == 2)
    {
        gl_FragColor = texture2D(uTexture0, vTexCoord) * 0.29411764705882354;
        gl_FragColor += texture2D(uTexture0, vTexCoord + vec2(-1.3333333333333333) * uStep) * 0.35294117647058826;
        gl_FragColor += texture2D(uTexture0, vTexCoord + vec2(1.3333333333333333) * uStep) * 0.35294117647058826;
    }
    else{
        gl_FragColor = texture2D(uTexture0, vTexCoord) * 0.44198;
        gl_FragColor += texture2D(uTexture0, vTexCoord + vec2(-1.0) * uStep) * 0.27901;
        gl_FragColor += texture2D(uTexture0, vTexCoord + vec2(1.0) * uStep) * 0.27901;
    }
}
