if( isExperienceOrb(Color) ){
  vec4 gradient = vec4(0.);
  int colourArrayLength = XP_ORB_COLOURS.length();

  float random_offset = XP_ORB_RANDOM_OFFSET ? ( floor(texCoord0.x * 4.) + floor(texCoord0.y * 4.) ) / 9600. : 0.;

  float gradientrender_GRADIENT_ANIM = 0.;
  float animDirection = XP_ORB_REVERSE_ANIMATION_DIRECTION ? -1. : 1.;
  float animTime = (GameTime + random_offset) * animDirection;
  switch ( XP_ORB_ANIMATION_MODE ) {
    case 0:
    // distance based
    gradientrender_GRADIENT_ANIM = fract(mod((animTime * (XP_ORB_ANIMATION_SPEED / float(colourArrayLength)) + (sphericalDistance/ XP_ORB_ANIMATION_COLOUR_PERIOD ) ), 2.) - 1.);
    break;
    case 2:
    // colour cycle
    gradientrender_GRADIENT_ANIM = fract(mod(animTime * (XP_ORB_ANIMATION_SPEED / float(colourArrayLength)), 2.) - 1.);
    break;
    case 3:
    // loop colour cycle
    gradientrender_GRADIENT_ANIM = abs(mod((animTime * (XP_ORB_ANIMATION_SPEED / float(colourArrayLength)) * 2.), 2.) - 1.);
  }
  
  for(int i = 0; i < colourArrayLength; i++) {
    float i_f = XP_ORB_ANIMATION_MODE == 3 ? float(i) - 1. : float(i);
    float len_f = XP_ORB_ANIMATION_MODE == 3 ? float(colourArrayLength) - 1. : float(colourArrayLength);
    
    float _step = XP_ORB_SMOOTH_MIX ? i_f/len_f : (i_f+0.5)/len_f;
    float _step2 = XP_ORB_SMOOTH_MIX ? (i_f+1.)/len_f : (i_f-0.5)/len_f;
    
    gradient = mix(
    i == 0 ? XP_ORB_COLOURS[colourArrayLength-1] : gradient,
    XP_ORB_COLOURS[i],
    XP_ORB_SMOOTH_MIX ? smoothstep(_step, _step2, gradientrender_GRADIENT_ANIM) : step(_step, gradientrender_GRADIENT_ANIM)
    );
  }

  if( XP_ORB_EMISSIVE ) {
    vertexColor = gradient;
  }
  else {
    vertexColor = gradient * texelFetch(Sampler2, UV2 / 16, 0);
  }
}