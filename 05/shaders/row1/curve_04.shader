shader_type canvas_item;

float plot(vec2 uv, float calculated_y, float line_width)
{
	float half_line_width = line_width / 2.0;
	return smoothstep(calculated_y - half_line_width, calculated_y, uv.y) 
			- smoothstep(calculated_y, calculated_y + half_line_width, uv.y);
}

vec2 flip_y(vec2 vec)
{
	vec.y = 1.0-vec.y;
	return vec;
}

void fragment()
{
	vec2 uv = flip_y(UV);
	
	// Make the x-axis correspond to -1...1
	uv.x = mix(-1.0, 1.0, uv.x);
		
	float x = uv.x;
	
	float y = 1.0 - pow(abs(x), 2.5);	
	
	COLOR = vec4(plot(uv, y, 0.05), 0, 0, 1.0);	
}