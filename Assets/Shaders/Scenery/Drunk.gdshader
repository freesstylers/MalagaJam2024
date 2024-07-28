shader_type canvas_item;

uniform sampler2D SCREEN_TEXTURE: hint_screen_texture, filter_linear_mipmap;
uniform sampler2D noise_1;
uniform sampler2D noise_2;

//potencia maxima de los efecto
uniform float potencia_efecto = 1;
uniform float potencia_color = 1;

uniform float distorsion_factor = 0.1;
uniform float distorsion_speed = 1;


void fragment() {
	vec2 noise_uv = fract(SCREEN_UV+TIME*distorsion_speed);
	vec2 noise_uv2 = fract(SCREEN_UV-TIME*distorsion_speed + vec2(0.3, 0.6));
	
	vec2 noise = vec2(texture(noise_1, noise_uv).r, texture(noise_2, noise_uv).r);
	vec2 noise2 = vec2(texture(noise_1, noise_uv2).r, texture(noise_2, noise_uv2).r);
	
	vec2 base_uv = SCREEN_UV + (noise2)*distorsion_factor*potencia_efecto/1000.0;
	COLOR = COLOR*distorsion_factor*potencia_color/100.0 + texture(SCREEN_TEXTURE, base_uv);
}
