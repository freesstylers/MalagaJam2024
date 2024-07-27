shader_type spatial;

uniform vec2 dir = vec2(1.0, 0.0); //Direccion a la lopeara la textura
uniform float multiply = 1.0f;
uniform sampler2D albedo_texture : filter_nearest, source_color;
uniform float offset = 00.0f;
uniform float time;

void fragment() {
	
	vec2 nuv = vec2(UV.x + offset*dir.x, UV.y + offset*dir.y);
	vec4 text = texture( albedo_texture , nuv);
	ALBEDO = text.rgb;
	ALPHA = text.a;
}
