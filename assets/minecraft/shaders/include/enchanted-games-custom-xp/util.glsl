bool rougheq(vec4 color, vec4 target) {
  return all(lessThan(abs(color-target),vec4(0.0001)));
}
bool rougheq(vec3 color, vec3 target) {
  return all(lessThan(abs(color-target),vec3(0.0001)));
}
bool rougheq(vec2 color, vec2 target) {
  return all(lessThan(abs(color-target),vec2(0.0001)));
}
bool rougheq(float color, float target) {
  return abs(color-target) < 0.0001;
}
bool inrange(float test, float min, float max) {
  return (min - 0.0001) <= test &&  test <= (max + 0.0001);
}
int toint(vec3 col) {
  ivec3 icol = ivec3(col*255);
  return (icol.r << 16) + (icol.g << 8) + icol.b;
}