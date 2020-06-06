#ifdef GL_ES
precision mediump float;
precision mediump int;
#endif

uniform sampler2D texture;
uniform vec2 texOffset;

varying vec4 vertColor;
varying vec4 vertTexCoord;

void main() {

  vec2 texl = vertTexCoord.st;
  vec4 pixl = texture2D(texture, texl);

  float luma = pixl.r*0.2126 + pixl.g*0.7152 + pixl.b*0.0722;
  gl_FragColor = vec4(luma,luma,luma, 1.0);

}
