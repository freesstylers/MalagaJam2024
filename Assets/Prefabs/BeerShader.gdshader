shader_type canvas_item;

uniform sampler2D beer;
uniform float p = 0.00;

void fragment() {
	float aspectRatio = TEXTURE_PIXEL_SIZE.y/TEXTURE_PIXEL_SIZE.x;
	//vec4 realColor = texture(TEXTURE, UV);
	
	if (1.0 - UV.y <= p){
		vec2 uv = vec2(UV.x * 1.0, UV.y * 4.0);
		vec2 uv2 = uv;
		uv.y = fract(uv.y * aspectRatio + TIME);
		uv2.y = fract(uv2.y * aspectRatio + TIME*1.5);
		COLOR = min(texture(beer, uv), texture(beer, uv2));
	}
}

