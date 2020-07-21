shader_type canvas_item;

uniform vec2 mouse = vec2(0, 0);

const vec3 yellow = vec3(1.0, 1.0, 0.0);
const vec3 blue = vec3(0, 0, 1.0);

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


void fragment()
{	
	vec2 uv = flip_y(UV);

	bool corner = (uv.x < 0.3 || uv.x > 0.5)
		&& (uv.y < 0.4 || uv.y > 0.6);
	
	vec3 color = corner ?  blue : yellow;
	
	COLOR = vec4(color, 1.0);
}
