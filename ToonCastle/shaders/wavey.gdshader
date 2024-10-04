shader_type canvas_item;

uniform sampler2D screen_texture:hint_screen_texture, repeat_disable, filter_nearest;
uniform sampler2D noise_texture:repeat_enable;
// red color!
//void fragment() {
	//vec3 color = texture(screen_texture, SCREEN_UV).rgb;
	//color.g = 0.0;
	//color.b = 0.0;
	//COLOR.rgb = color;
//}

void fragment(){
	vec3 noise_color = texture(noise_texture, SCREEN_UV + (TIME / 10.0)).rgb;
	vec3 color = texture(screen_texture, SCREEN_UV + (noise_color.b / 20.0)).rgb;

	// blue
	//color.r = 0.0;
	//color.g = 0.0;

	// b & w
	//color.r = color.b;
	//color.g = color.b;

	COLOR.rgb = color;
}
