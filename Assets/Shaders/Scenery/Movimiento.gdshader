shader_type spatial;

uniform vec2 velocidad = vec2(1.0, 0.0);
uniform float multiply = 1.0f;
uniform sampler2D albedo_texture : filter_nearest, source_color;

void fragment() {
	vec2 nuv = vec2(UV.x + (TIME/60.0f * velocidad.x * multiply), UV.y + (TIME/60.0f * velocidad.y * multiply));
	vec4 text = texture( albedo_texture , nuv);
	ALBEDO = text.rgb;
	ALPHA = text.a;
}
