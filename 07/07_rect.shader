shader_type canvas_item;

uniform vec2 mouse = vec2(0, 0);
uniform vec2 dimension = vec2(1024, 600);

const float pi = 3.14159265359;
const float pi_2 = pi * 2.0;

const vec3 red = vec3(1.0, 0, 0);
const vec3 blue = vec3(0, 0, 1.0);
const vec3 white = vec3(1.0);
const vec3 black = vec3(0.0);
const vec3 biege = vec3(247.0/255.0, 240.0/255.0, 220.0/255.0);

vec2 flip_y(vec2 vec)
{
	vec.y = 1.0-vec.y;
	return vec;
}

// gradient_amount is generally very small; it is also in rage 0...1 of the enture UV-range.
vec3 rect_impl(vec2 coord, in vec2 lower_left_corner, in vec2 upper_right_corner, float gradient_amount)
{
	vec2 lower_left = vec2(0.0);
	vec2 upper_right = vec2(0.0);
	
	if (gradient_amount > 0.0)
	{
		// Only do gradient if we're inside the desired area
		if (coord.x >= lower_left_corner.x
		    && coord.y >= lower_left_corner.y
		    && coord.x <= upper_right_corner.x
			&& coord.y <= upper_right_corner.y)
		{
			lower_left = vec2(1.0) - smoothstep(vec2(gradient_amount), vec2(0.0), coord - lower_left_corner);
			upper_right = vec2(1.0) - smoothstep(vec2(gradient_amount), vec2(0.0), upper_right_corner - coord);
		}
	}
	else
	{
		lower_left = step(lower_left_corner, coord);
		upper_right = step(coord, upper_right_corner);
	}
	
	return vec3(lower_left.x * lower_left.y * upper_right.x * upper_right.y);
}

// margins: x: left, y: upper, z: right, w: lower
vec3 rect(vec2 coord, in vec2 lower_left_corner, in vec2 upper_right_corner, float gradient_amount)
{
	return rect_impl(coord, lower_left_corner, upper_right_corner, gradient_amount);
}

vec3 rect_outline(vec2 coord, vec2 lower_left_corner, vec2 upper_right_corner, float width, float gradient_amount)
{
	// Draw two recatangles, one inside the other to create an outline.
	vec3 outer = rect(coord, lower_left_corner, upper_right_corner,
											 gradient_amount);
				
	vec3 inner = rect(coord, vec2(lower_left_corner.x + width, lower_left_corner.y + width),
							 vec2(upper_right_corner.x - width, upper_right_corner.y - width),
											 gradient_amount);
											
	return outer - inner;
}

void fragment()
{	
	vec2 uv = flip_y(UV);
    
	vec3 color = biege;
	float gradient_amount = 0.002;
	float line_width = 0.02;
		
	vec3 intensity = rect(uv, vec2(0.0, 0.65), vec2(0.25, 1.0), gradient_amount);
	color = mix(color, red, intensity);
		
	intensity = rect_outline(uv, vec2(-line_width, 0.85), vec2(1.1, 1.0 + line_width), line_width, gradient_amount);
	color = mix(color, black, intensity);
	
	intensity = rect_outline(uv, vec2(-line_width, 0.65), vec2(1.1, 1.0 + line_width), line_width, gradient_amount);
	color = mix(color, black, intensity);
	
	intensity = rect_outline(uv, vec2(-line_width, -line_width), vec2(0.25, 1.0 + line_width), line_width, gradient_amount);
	color = mix(color, black, intensity);
	

    COLOR = vec4(color,1.0);	
}

//void fragment()
//{	
//	vec2 uv = flip_y(UV);
//
//	// Each result will return 1.0 (white) or 0.0 (black).
//	// vec2 bottom_left = step(vec2(0.1), uv);
//	// vec2 top_right = step(vec2(0.1), 1.0 - uv);
//
//	vec2 bottom_left = smoothstep(vec2(0), vec2(0.1), uv);
//	vec2 top_right = smoothstep(vec2(0), vec2(0.1), 1.0 - uv);
//
//	//vec2 bottom_left = step(vec2(1.0), floor(uv * 10.0));
//	//vec2 top_right = step(vec2(1.0), floor(10.0 - uv * 10.0));
//
//    // The multiplication of left*bottom will be similar to the logical AND.
//    vec3 color = vec3( bottom_left.x * bottom_left.y * top_right.x * top_right.y);
//
//    COLOR = vec4(color,1.0);	
//}