#version 150

#moj_import <fog.glsl>

uniform sampler2D Sampler0;

uniform vec4 ColorModulator;
uniform float FogStart;
uniform float FogEnd;
uniform vec4 FogColor;
uniform float GameTime;

in float vertexDistance;
in vec4 vertexColor;
in vec2 texCoord0;
in vec2 texCoord1;
in vec4 normal;
in vec4 tintColour;

out vec4 fragColor;

vec4 colour1 = vec4(0.27451, 1, 0.86667, 0.8);
vec4 colour2 = vec4(0.41569, 0.96078, 1, 0.7);

void main() {
    vec4 color = texture(Sampler0, texCoord0) * ColorModulator;
    if (color.a < 0.1) {
        discard;
    }

    // detect xp orbs using their tint colour
    vec4 col255 = tintColour * 255;
    if(
        0 <= col255.r && col255.r <= 255 &&
        253 <= col255.g && col255.g <= 255 &&
        0 <= col255.b && col255.b <= 51
    ){
        fragColor = linear_fog(
            mix(colour1, colour2, tintColour.r) * color,
            vertexDistance, FogStart, FogEnd, FogColor);
    }
    else{
        fragColor = linear_fog(color * vertexColor, vertexDistance, FogStart, FogEnd, FogColor);
    }

}