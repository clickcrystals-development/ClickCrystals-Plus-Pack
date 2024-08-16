if( inrange(color.b, 1./255., 6./255.) && rougheq(color.a, 191./255.) ) {
    float gradientBrightness = color.r;
    
    float animDirection = XP_BAR_REVERSE_ANIMATION_DIRECTION ? -1. : 1.;
    float animTime = GameTime * animDirection;
    float animCoord = 0.;
    vec2 barCoord = vec2(color.g, color.b);
    
    switch (XP_BAR_ANIMATION_MODE) {
    case 0:
        animCoord = barCoord.y;
        break;
    case 1:
        animCoord = barCoord.x;
        break;
    case 2:
        animCoord = barCoord.x - barCoord.y;
        break;
    case 3:
        animCoord = barCoord.x + barCoord.y;
        break;
    case 4:
        animCoord = abs(barCoord.x - 0.5);
        break;
    default:
        break;
    }
    int colourArrayLength = XP_BAR_COLOURS.length();
    float gradientrender_GRADIENT_ANIM = fract(mod( (animTime * ( XP_BAR_ANIMATION_SPEED / float(colourArrayLength) ) + ( animCoord / ( (XP_BAR_ANIMATION_COLOUR_PERIOD / 18.) ) ) ), 2.) - 1.);
    
    vec4 gradient = vec4(0.);

    float len = float(colourArrayLength);
    for(int i = 0; i < colourArrayLength; i++){
        float _step = XP_BAR_SMOOTH_MIX ? float(i)/len : (float(i)+0.5)/len;
        float _step2 = XP_BAR_SMOOTH_MIX ? (float(i)+1.)/len : (float(i)-0.5)/len;

        gradient = mix(
            i == 0 ? XP_BAR_COLOURS[colourArrayLength-1] : gradient,
            XP_BAR_COLOURS[i],
            XP_BAR_SMOOTH_MIX ? smoothstep(_step, _step2, gradientrender_GRADIENT_ANIM) : step(_step, gradientrender_GRADIENT_ANIM)
        );
    }

    color = vec4(vec3(gradientBrightness) * gradient.rgb, 1.);
}