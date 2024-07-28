shader_type canvas_item;

uniform sampler2D beer;

void fragment() {	
	vec2 uv = UV;
	vec2 uv2 = UV;
	uv.y = fract(uv.y + TIME/8.0);
	uv2.y = fract(uv2.y + TIME/4.0);
	COLOR = texture(TEXTURE, UV) * min(texture(beer, uv), texture(beer, uv2));
	
}

