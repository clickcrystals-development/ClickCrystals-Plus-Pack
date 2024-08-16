switch ( toint(Color.rgb) ) {
  case 0x80ff20:
    vertexColor.rgb = XP_TEXT_MAIN_COLOUR * texelFetch(Sampler2, UV2 / 16, 0).rgb;
    break;
  case 0x203f08:
    vertexColor.rgb = XP_TEXT_SHADOW_COLOUR * texelFetch(Sampler2, UV2 / 16, 0).rgb;
    break;
  case 0x407f10:
    vertexColor.rgb = XP_TEXT_MAIN_COLOUR * texelFetch(Sampler2, UV2 / 16, 0).rgb;
    vertexColor.rgb *= 0.7;
    break;
  case 0x101f04:
    vertexColor.rgb = XP_TEXT_SHADOW_COLOUR * texelFetch(Sampler2, UV2 / 16, 0).rgb;
    vertexColor.rgb *= 0.7;
    break;
}