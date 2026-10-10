#extension GL_OES_EGL_image_external : require
precision mediump float;
varying vec2 vTextureCoord;
uniform int usingLut;
uniform float uPercent;
uniform samplerExternalOES sTexture;
uniform sampler2D inputImageTexture;

lowp vec3 lut512(highp vec3 textureColor) {
    highp float redColor = max(min(1.0,textureColor.r),0.0);
    highp float greenColor = max(min(1.0,textureColor.g),0.0);
    highp float blueColor = textureColor.b * 63.0;

    mediump vec2 quad1;
    quad1.y = floor(floor(blueColor) / 8.0);
    quad1.y = max(min(8.0,quad1.y),0.0);
    quad1.x = floor(blueColor) - (quad1.y * 8.0);
    quad1.x = max(min(8.0,quad1.x),0.0);
    mediump vec2 quad2;
    quad2.y = max(min(8.0,floor(ceil(blueColor) / 8.0)),0.0);
    quad2.x = max(min(8.0,ceil(blueColor) - (quad2.y * 8.0)),0.0);

    highp vec2 texPos1;
    texPos1.x = (quad1.x * 0.125) + 0.5/512.0 + ((0.125 - 1.0/512.0) * redColor);
    texPos1.y = (quad1.y * 0.125) + 0.5/512.0 + ((0.125 - 1.0/512.0) * greenColor);
    highp vec2 texPos2;
    texPos2.x = (quad2.x * 0.125) + 0.5/512.0 + ((0.125 - 1.0/512.0) * redColor);
    texPos2.y = (quad2.y * 0.125) + 0.5/512.0 + ((0.125 - 1.0/512.0) * greenColor);

    lowp vec4 newColor1 = texture2D(inputImageTexture, texPos1);
    lowp vec4 newColor2 = texture2D(inputImageTexture, texPos2);
    lowp vec4 newColor = mix(newColor1, newColor2, fract(blueColor));
    return newColor.rgb;
}

lowp vec3 lut64(highp vec3 textureColor) {
    highp float redColor = max(min(1.0,textureColor.r),0.0);
    highp float greenColor = max(min(1.0,textureColor.g),0.0);
    highp float blueColor = textureColor.b * 15.0;

    mediump vec2 quad1;
    quad1.y = max(min(4.0,floor(floor(blueColor) / 4.0)),0.0);
    quad1.x = max(min(4.0,floor(blueColor) - (quad1.y * 4.0)),0.0);
    mediump vec2 quad2;
    quad2.y = max(min(4.0,floor(ceil(blueColor) / 4.0)),0.0);
    quad2.x = max(min(4.0,ceil(blueColor) - (quad2.y * 4.0)),0.0);

    highp vec2 texPos1;
    texPos1.x = (quad1.x * 0.25) + 0.5/64.0 + ((0.25 - 1.0/64.0) * redColor);
    texPos1.y = (quad1.y * 0.25) + 0.5/64.0 + ((0.25 - 1.0/64.0) * greenColor);
    highp vec2 texPos2;
    texPos2.x = (quad2.x * 0.25) + 0.5/64.0 + ((0.25 - 1.0/64.0) * redColor);
    texPos2.y = (quad2.y * 0.25) + 0.5/64.0 + ((0.25 - 1.0/64.0) * greenColor);

    lowp vec4 newColor1 = texture2D(inputImageTexture, texPos1);
    lowp vec4 newColor2 = texture2D(inputImageTexture, texPos2);
    lowp vec4 newColor = mix(newColor1, newColor2, fract(blueColor));
    return newColor.rgb;
}

lowp vec3 lut256(highp vec3 textureColor) {
    highp float redColor = max(min(1.0,textureColor.r),0.0);
    highp float greenColor = max(min(1.0,textureColor.g),0.0);
    highp float blueColor = max(min(1.0,textureColor.b),0.0);

    lowp vec3 newColor;
    newColor.r = texture2D(inputImageTexture, vec2(redColor,0.5)).r;
    newColor.g = texture2D(inputImageTexture, vec2(greenColor,0.5)).g;
    newColor.b = texture2D(inputImageTexture, vec2(blueColor,0.5)).b;

    return newColor;
}

void main() {
    highp vec4 textureColor = texture2D(sTexture, vTextureCoord);
    if (usingLut == 1) {
        gl_FragColor = vec4(mix(textureColor.rgb, lut64(textureColor.rgb), uPercent), textureColor.w);
    } else if (usingLut == 2) {
        gl_FragColor = vec4(mix(textureColor.rgb, lut256(textureColor.rgb), uPercent), textureColor.w);
    } else if (usingLut == 3) {
        gl_FragColor = vec4(mix(textureColor.rgb, lut512(textureColor.rgb), uPercent), textureColor.w);
    } else {
        gl_FragColor = textureColor;
    }
}
