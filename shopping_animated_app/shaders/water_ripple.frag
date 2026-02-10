#include <flutter/runtime_effect.glsl>

precision highp float;

uniform sampler2D uTexture;
uniform vec2 uSize;
uniform vec2 uCenter;
uniform float uTime;
uniform float uAmplitude;
uniform float uFrequency;
uniform float uDecay;

out vec4 fragColor;

void main() {
  vec2 uv = FlutterFragCoord().xy / uSize;
  vec2 center = uCenter / uSize;
  vec2 dir = uv - center;
  float dist = length(dir);

  float wave = sin((dist * uFrequency - uTime * 6.2831853)) * uAmplitude;
  float fade = exp(-dist * uDecay);
  float strength = wave * fade;

  vec2 offset = dist > 0.0 ? normalize(dir) * strength : vec2(0.0);
  vec4 color = texture(uTexture, uv + offset);

  fragColor = color;
}
