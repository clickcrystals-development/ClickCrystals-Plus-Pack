#version 150

#moj_import <fog.glsl>

uniform sampler2D Sampler0;

uniform vec4 ColorModulator;
uniform float FogStart;
uniform float FogEnd;
uniform vec4 FogColor;
uniform float GameTime;
uniform mat4 ProjMat;

in float vertexDistance;
in vec2 texCoord0;
in vec3 pos;
in vec4 tintColor;
in vec4 lighting;

out vec4 fragColor;

bool roughlyEquals(vec3 colour, vec3 compare_colour) {
    // compares if 2 colours are equal to eachother within a range of error
    float ERROR_RANGE = 0.00001;

    vec3 compare_lower = compare_colour - ERROR_RANGE;
    vec3 compare_upper = compare_colour + ERROR_RANGE;

    if( (colour.r >= compare_lower.r && colour.r <= compare_upper.r)
        && (colour.g >= compare_lower.g && colour.g <= compare_upper.g)
        && (colour.b >= compare_lower.b && colour.b <= compare_upper.b) ) {
        return true;
    }else{
        return false;
    }
}
bool isShadow() {
    // returns true if text is considered as a "text shadow"
    if(ProjMat[3][0] == -1 && (pos.z == 200 || pos.z == 300 || pos.z == -200 || pos.z == 0.01 || pos.z == 0 || pos.z == 100.01 || pos.z == 100 || pos.z == 400 ) ) {
        return true;
    } 
    else {
        return false;
    }
}

bool inGUI() {
    // max vertex distance for text to be classed as in a gui
    float maxVertDistance = 800;

    if(vertexDistance >= maxVertDistance){
        return true;
    } else{
        return false;
    }
}

void main() {
    vec4 color = texture(Sampler0, texCoord0) * lighting * ColorModulator;
    vec4 tint = tintColor;
    if (color.a < 0.1) {
        discard;
    }

    // Enchanting Colours - enchanting_colours[]
    // Experience text
    if( roughlyEquals( tintColor.rgb, vec3(0.5019607843137255, 1, 0.12549019607843137) ) && inGUI()){
        tint.rgb = vec3(0.22745, 1, 0.88627);
    }
    // Experience text shadow
    else if( roughlyEquals( tintColor.rgb, vec3(0.12549019607843137, 0.24705882352941178, 0.03137254901960784) ) && isShadow() && inGUI() ){
        tint.rgb = vec3(0.24706, 0.24706, 0.24706);
    }

    // not enough xp text
    else if( roughlyEquals( tintColor.rgb, vec3(0.25098039215686274, 0.4980392156862745, 0.06274509803921569) ) && inGUI()){
        tint.rgb = vec3(0.87059, 0.10588, 0.10588);
    }
    // not enough xp text shadow
    else if( roughlyEquals( tintColor.rgb, vec3(0.06274509803921569, 0.12156862745098039, 0.01568627450980392) ) && isShadow() && inGUI() ){
        tint.rgb = vec3(0.36471, 0.04314, 0.04314);
    }
    

    fragColor = color * tint;
}