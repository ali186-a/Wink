varying highp vec2 textureCoordinate;
uniform sampler2D inputImageTexture;
uniform sampler2D inputImageTexture2;
uniform sampler2D inputImageTexture3;
uniform sampler2D facialBeautifyMaskTexture;

uniform lowp float laughLineAlpha;
uniform lowp float removePouchAlpha;
uniform lowp float maxImDiff;

#ifndef WITHOUT_BRIGHT_EYE
uniform sampler2D lookUpBrightEye;
uniform lowp float brightEyeAlpha;
uniform highp float stepSize1;
uniform highp float stepSize2;
uniform lowp float brightEyeCurveAlpha;
uniform lowp float brightEyeSharpenAlpha;
#endif
//mediump vec3 gray = (0.299,0.587,0.114);

void main()
{

    lowp vec4 iColor = texture2D(inputImageTexture, textureCoordinate);
    lowp vec3 faceMaskColor = texture2D(facialBeautifyMaskTexture, textureCoordinate).rgb;
    lowp vec3 color = iColor.rgb;
    if (faceMaskColor.g > 0.0500) {
#ifndef WITHOUT_BRIGHT_EYE
            highp vec2 step1 = vec2(stepSize1, 0.0);
            highp vec2 step2 = vec2(0.0, stepSize2);
            highp vec3 sumColor = iColor.rgb;
            sumColor += texture2D(inputImageTexture,textureCoordinate + (-2.0) * step1).rgb;
            sumColor += texture2D(inputImageTexture,textureCoordinate +  2.0   * step1).rgb;
            sumColor += texture2D(inputImageTexture,textureCoordinate + (-2.0) * step2).rgb;
            sumColor += texture2D(inputImageTexture,textureCoordinate +  2.0   * step2).rgb;
            
            sumColor += texture2D(inputImageTexture,textureCoordinate + step1).rgb;
            sumColor += texture2D(inputImageTexture,textureCoordinate - step1).rgb;
            sumColor += texture2D(inputImageTexture,textureCoordinate + step2).rgb;
            sumColor += texture2D(inputImageTexture,textureCoordinate - step2).rgb;
            
            sumColor += texture2D(inputImageTexture,textureCoordinate + -step1 +  step2).rgb;
            sumColor += texture2D(inputImageTexture,textureCoordinate + -step1 + -step2).rgb;
            sumColor += texture2D(inputImageTexture,textureCoordinate +  step1 +  step2).rgb;
            sumColor += texture2D(inputImageTexture,textureCoordinate +  step1 + -step2).rgb;
    //        sumColor = sumColor * 0.11111;
            sumColor = sumColor * 0.07692;
            highp vec3 sumColor2 = texture2D(inputImageTexture2,textureCoordinate).rgb;
            lowp vec3 stepSumColor = step(0.0,(color.rgb - sumColor2).rgb);
            highp vec3 stepSumColor2 = clamp(5.0 * (color.g + 0.7) * (color.rgb - sumColor2.rgb + 0.1),0.0,1.0);
            stepSumColor2 = mix(stepSumColor2,vec3(1.0,1.0,1.0),stepSumColor);
            sumColor = clamp(sumColor + (color.rgb - sumColor) * brightEyeSharpenAlpha, 0.0, 1.0);
            sumColor = max(color.rgb - 0.05, sumColor);
            highp vec3 sumColorBright = sumColor;
            sumColorBright.r = texture2D(lookUpBrightEye, vec2(sumColor.r, 0.5)).r;
            sumColorBright.g = texture2D(lookUpBrightEye, vec2(sumColor.g, 0.5)).g;
            sumColorBright.b = texture2D(lookUpBrightEye, vec2(sumColor.b, 0.5)).b;
            sumColorBright = mix(sumColor, sumColorBright, brightEyeCurveAlpha * stepSumColor2);
            color = mix(color, sumColorBright, brightEyeAlpha * faceMaskColor.g);
#endif
        } else {
            lowp vec3 sumColor = texture2D(inputImageTexture2, textureCoordinate).rgb;
            lowp vec3 sumColor2 = texture2D(inputImageTexture3, textureCoordinate).rgb;
            lowp vec3 sum = sumColor;
            lowp vec3 sum2 = sumColor2;
            
            lowp vec3 imDiff;
            
            imDiff=clamp((sum2-sum)*1.3+0.03*sum2,0.0,maxImDiff);
            imDiff=min(color+imDiff, 1.0);
            lowp float alpha = max(removePouchAlpha * faceMaskColor.r, laughLineAlpha * faceMaskColor.b);
            color = mix(iColor.rgb, imDiff, alpha);
    }
    
    gl_FragColor = vec4(color, iColor.a);
}
