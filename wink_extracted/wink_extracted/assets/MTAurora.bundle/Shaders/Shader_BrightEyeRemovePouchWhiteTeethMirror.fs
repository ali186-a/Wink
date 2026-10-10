varying highp vec2 textureCoordinate;
uniform sampler2D inputImageTexture;
uniform sampler2D inputImageTexture2;
uniform sampler2D inputImageTexture3;
uniform sampler2D facialBeautifyMaskTexture;

uniform lowp float laughLineAlpha;
uniform lowp float removePouchAlpha;
uniform lowp float maxImDiff;

#ifndef WITHOUT_BRIGHT_EYE
uniform lowp float brightEyeAlpha;
uniform lowp float brightEyeShadowAlpha;
uniform highp float stepSize1;
uniform highp float stepSize2;
#endif

lowp vec3 sum;
lowp vec3 sum2;
lowp vec3 color;

void main()
{

    lowp vec4 iColor = texture2D(inputImageTexture, textureCoordinate);
    lowp vec3 faceMaskColor = texture2D(facialBeautifyMaskTexture, textureCoordinate).rgb;
    color = iColor.rgb;
    
    //pouch
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
    } else if(faceMaskColor.r > 0.05){
        lowp vec3 sumColor = texture2D(inputImageTexture2, textureCoordinate).rgb;
        lowp vec3 sumColor2 = texture2D(inputImageTexture3, textureCoordinate).rgb;
        
        lowp vec3 imDiff;
        sum = sumColor;
        sum2 = sumColor2;
        
        imDiff=clamp((sum2-sum)*1.3+0.03*sum2,0.0,maxImDiff);
        imDiff = min(color + imDiff, 1.0);
        
        //color = mix(iColor, imDiff, removePouchAlpha * faceMaskColor.b);
        
        lowp vec3 grayColor = imDiff;
        lowp vec3 brightColor = clamp(grayColor * grayColor * -0.0014 + 1.3452 * grayColor, 0.0, 1.0);
        
        color = mix(iColor.rgb, brightColor, removePouchAlpha * faceMaskColor.r);
    } else {
        lowp vec3 sumColor = texture2D(inputImageTexture2, textureCoordinate).rgb;
        lowp vec3 sumColor2 = texture2D(inputImageTexture3, textureCoordinate).rgb;
        
        lowp vec3 imDiff;
        sum = sumColor;
        sum2 = sumColor2;
        
        imDiff=clamp((sum2-sum)*1.3+0.03*sum2,0.0,maxImDiff);
        imDiff=min(color+imDiff, 1.0);
        
        color = mix(iColor.rgb, imDiff, laughLineAlpha * faceMaskColor.b);
    }
    
    gl_FragColor = vec4(color, iColor.a);
}
