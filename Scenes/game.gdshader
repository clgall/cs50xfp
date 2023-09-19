shader_type canvas_item;

uniform float speed;

void fragment() {
	// Place fragment code here.
	COLOR = texture(TEXTURE, vec2(UV.x,UV.y - TIME * speed));	
	COLOR.r = 0.6;
	COLOR.g = 0.9;
}
