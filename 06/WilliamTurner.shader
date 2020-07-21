shader_type canvas_item;

uniform vec2 mouse = vec2(0, 0);

const vec3 smokey = vec3(1.0, 1.0, 1.0);
const vec3 sunset_orange = vec3(0.882352941,0.443137255,0.043137255);
const vec3 background = vec3(18.0/255.0, 59.0/255.0, 200.0/255.0);

const float pi = 3.14159265359;
const float pi_2 = pi * 2.0;

vec2 flip_y(vec2 vec)
{
	vec.y = 1.0-vec.y;
	return vec;
}

float plot(vec2 uv, float calculated_y, float line_width)
{
	float half_line_width = line_width / 2.0;
	return smoothstep(calculated_y - half_line_width, calculated_y, uv.y) 
			- smoothstep(calculated_y, calculated_y + half_line_width, uv.y);
}

float ease_in_out_quint(float x)
{
	return x < 0.5 ? 16.0 * x * x * x * x * x : 1.0 - pow(-2.0 * x + 2.0, 5.0) / 2.0;
}

float ease_out_quad(float x)
{
	return 1.0 - (1.0 - x) * (1.0 - x);
}

void fragment()
{	
	vec2 uv = flip_y(UV);

	vec3 color = mix(background, smokey, uv.y);
	
	// Clouds
	vec3 cloud_gradient = vec3(uv.x);
	vec3 cloud_color = mix(smokey, sunset_orange, cloud_gradient);
	float y_offset = 0.7;
	vec2 cloud_path = vec2(uv.x, sin(uv.x * pi) * 0.1);	
	color = mix(color, cloud_color, plot(uv, cloud_path.y + y_offset, 1.5));
	
	// Center stroke
	vec2 center_path = vec2(uv.x, 0.2);
	color = mix(color, background * min(1.0, (uv.x + 0.5)), plot(uv, center_path.y, 0.3));

	// Reflection
	vec2 reflection_path = vec2(uv.x, 0.06);
	color = mix(color, sunset_orange * uv.x + 0.2, plot(uv, reflection_path.y, 0.6));

	// Sunset/sunrise
	//color *= max(0.2, ease_out_quad(sin(TIME)));
	
	// Rainbow
	color = mix(color, vec3(1.0, 0, 0), plot(uv, abs(sin(uv.x * pi)), 0.3));
	color = mix(color, vec3(0.0, 0.6, 0), plot(uv, abs(sin(uv.x * pi)) - 0.05, 0.3));
	color = mix(color, vec3(0.0, 0.0, .6), plot(uv, abs(sin(uv.x * pi)) - 0.1, 0.3));
		
	COLOR = vec4(color, 1.0);
}
