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
#endif

lowp vec3 sum;
lowp vec3 sum2;
lowp vec3 color;

void main()
{
    lowp vec4 iColor = texture2D(inputImageTexture, textureCoordinate);
    lowp vec3 faceMaskColor = texture2D(faceMaskTexture, textureCoordinate).rgb;
    color = iColor.rgb;
    
    //pouch
    if (faceMaskColor.g > 0.0500) {
#ifndef WITHOUT_BRIGHT_EYE
        lowp vec3 sumColor = texture2D(inputImageTexture2, textureCoordinate).rgb;
        sumColor = clamp(sumColor + (color - sumColor) * 3.0, 0.0, 1.0);
        color = max(color, sumColor);

        color = mix(iColor.rgb, color, brightEyeAlpha * faceMaskColor.g);
#endif
    } else {
        lowp vec3 sumColor = texture2D(inputImageTexture2, textureCoordinate).rgb;
        lowp vec3 sumColor2 = texture2D(inputImageTexture3, textureCoordinate).rgb;
        
        lowp vec3 imDiff;
        sum = sumColor;
        sum2 = sumColor2;
        
        imDiff=clamp((sum2-sum)*1.3+0.03*sum2,0.0,maxImDiff);
        imDiff=min(color+imDiff, 1.0);
        
         lowp float alpha = max(removePouchAlpha * faceMaskColor.r, laughLineAlpha * faceMaskColor.b);
        
        color = mix(iColor.rgb, imDiff, alpha);
    }
    
    gl_FragColor = vec4(color, iColor.a);
}
