varying highp vec2 textureCoordinate;
uniform sampler2D inputImageTexture;
uniform sampler2D inputImageTexture2;
uniform sampler2D inputImageTexture3;
uniform sampler2D facialBeautifyMaskTexture;

uniform lowp float laughLineAlpha;
uniform lowp float removePouchAlpha;
uniform lowp float maxImDiff;

#ifndef WITHOUT_BRIGHT_EYE
uniform lowp float brightEyeShadowAlpha;
uniform lowp float brightEyeAlpha;
uniform highp float stepSize1;
uniform highp float stepSize2;
#endif

void main()
{

    lowp vec4 iColor = texture2D(inputImageTexture, textureCoordinate);
    lowp vec3 faceMaskColor = texture2D(facialBeautifyMaskTexture, textureCoordinate).rgb;
    lowp vec3 color = iColor.rgb;
    
    //eye
    if (faceMaskColor.g > 0.0500) {
#ifndef WITHOUT_BRIGHT_EYE
        mediump float p = 0.0;
        mediump float t = 0.0;

        highp vec3 sumColor = vec3(0.0, 0.0, 0.0);
        for(t = -2.0; t < 2.5; t += 1.0){
            for(p = -2.0;p < 2.5;p += 1.0) {
                sumColor += texture2D(inputImageTexture, textureCoordinate + t * vec2(stepSize1, 0.0) + p * vec2(0.0, stepSize2)).rgb;
            }
        }
        
        sumColor = sumColor * 0.04;
        sumColor = clamp(sumColor + (color.rgb - sumColor) * 3.0, 0.0, 1.0);
        sumColor = max(color.rgb, sumColor);
        color = mix(color, sumColor, brightEyeAlpha * faceMaskColor.g);

        lowp vec3 grayColor = color;
        lowp vec3 brightColor = clamp(grayColor * grayColor * -0.3543 + 1.354 * grayColor, 0.0, 1.0);
        color = mix(grayColor, brightColor, faceMaskColor.b * brightEyeShadowAlpha);
        
        lowp vec3 shadowColor = clamp(grayColor * grayColor * 0.3401 + 0.6599 * grayColor, 0.0, 1.0);
        color = mix(color, shadowColor, faceMaskColor.r * brightEyeShadowAlpha);
#endif
    } else {
        lowp vec3 sumColor = texture2D(inputImageTexture2, textureCoordinate).rgb;
        lowp vec3 sumColor2 = texture2D(inputImageTexture3, textureCoordinate).rgb;
        
        lowp vec3 imDiff;
        
        imDiff=clamp((sumColor2-sumColor)*1.3+0.03*sumColor2,0.0,maxImDiff);
        imDiff=min(color+imDiff, 1.0);
        
        lowp float alpha = max(removePouchAlpha * faceMaskColor.r, laughLineAlpha * faceMaskColor.b);
        color = mix(iColor.rgb, imDiff, alpha);
    }
    
    gl_FragColor = vec4(color, iColor.a);
}
