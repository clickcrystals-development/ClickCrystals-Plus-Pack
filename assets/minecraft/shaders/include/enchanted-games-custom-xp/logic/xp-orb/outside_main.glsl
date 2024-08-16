uniform float GameTime;

bool isExperienceOrb(vec4 col) {
    vec4 col255 = col * 255;
    return 
        0 <= col255.r && col255.r <= 255 &&
        253 <= col255.g && col255.g <= 255 &&
        0 <= col255.b && col255.b <= 51
    ;
}