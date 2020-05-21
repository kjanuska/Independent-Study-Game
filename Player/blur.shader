shader_type canvas_item;

uniform float blur_amount : hint_range(0, 5);

void fragment() {
	vec4 color = texture(SCREEN_TEXTURE, SCREEN_UV, 4.0);
	COLOR = color;
}