#ifdef GL_ES
precision mediump float;
precision mediump int;
#endif

uniform sampler2D texture;
uniform vec2 texOffset;
uniform vec2 iResolution;

#define iChannel0 texture

varying vec4 vertColor;
varying vec4 vertTexCoord;

float character(float n, vec2 p)
{
	p = floor(p*vec2(4.0, -4.0) + 2.5);
	if (clamp(p.x, 0.0, 4.0) == p.x && clamp(p.y, 0.0, 4.0) == p.y)
	{
		if (int(mod(n/exp2(p.x + 5.0*p.y), 2.0)) == 1) return 1.0;
	}
	return 0.0;
}

void main() {

    vec2 texl = gl_FragCoord.xy;
		//vec3 pixl = texture(iChannel0, floor(texl/8.0)*8.0/iResolution.xy).rgb;
		vec3 pixl =texture2D(texture, floor(texl/8.0)*8.0/iResolution.xy).xyz;
    float luma = pixl.r*0.2126 + pixl.g*0.7152 + pixl.b*0.0722;

    float n =  4096.0;             // .
    if (luma > 0.2) n = 65600.0;    // :
    if (luma > 0.3) n = 332772.0;   // *
    if (luma > 0.4) n = 15255086.0; // o
    if (luma > 0.5) n = 23385164.0; // &
    if (luma > 0.6) n = 15252014.0; // 8
    if (luma > 0.7) n = 13199452.0; // @
    if (luma > 0.8) n = 11512810.0; // #

    vec2 p = mod(texl/4.0, 2.0) - vec2(1.0);
    vec3 col = luma*vec3(character(n, p));
    gl_FragColor = vec4(col, 1.0);

}
