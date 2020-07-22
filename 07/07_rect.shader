shader_type canvas_item;

uniform vec2 mouse = vec2(0, 0);
uniform vec2 dimension = vec2(1024, 600);

const float pi = 3.14159265359;
const float pi_2 = pi * 2.0;

const vec3 red = vec3(1.0, 0, 0);
const vec3 blue = vec3(0, 0, 1.0);
const vec3 white = vec3(1.0);
const vec3 black = vec3(0.0);

vec2 flip_y(vec2 vec)
{
	vec.y = 1.0-vec.y;
	return vec;
}

vec3 rect_impl(vec2 coord, in vec2 lower_left_margin, in vec2 upper_right_margin, float gradient_amount)
{
	vec2 lower_left;
	vec2 upper_right;
	
	if (gradient_amount > 0.0)
	{
		lower_left = smoothstep(vec2(lower_left_margin / 2.0 - gradient_amount), lower_left_margin / 2.0 + gradient_amount, coord);
		upper_right = smoothstep(vec2(upper_right_margin / 2.0 - gradient_amount), upper_right_margin / 2.0 + gradient_amount, 1.0 - coord);
	}
	else
	{
		lower_left = step(lower_left_margin, coord);
		upper_right = step(upper_right_margin, 1.0 - coord);
	}
	
	return vec3(lower_left.x * lower_left.y * upper_right.x * upper_right.y);
}

// margins: x: left, y: upper, z: right, w: lower
vec3 rect_margin(vec2 coord, in vec4 margins, float gradient_amount)
{
	return rect_impl(coord, vec2(margins.x, margins.w), vec2(margins.z, margins.y), gradient_amount);
}

vec3 rect_outline(vec2 coord, vec2 lower_left_corner, vec2 upper_right_corner, float width, float gradient_amount)
{
	// Draw two triagles, one inside the other to create an outline.
	vec3 outer = rect_margin(coord, vec4(lower_left_corner.x,
											 1.0 - upper_right_corner.y,
											 1.0 - upper_right_corner.x,
											 lower_left_corner.y),
											 gradient_amount);
				
	vec3 inner = rect_margin(coord, vec4(lower_left_corner.x + width,
											 1.0 - (upper_right_corner.y - width),
											 1.0 - (upper_right_corner.x - width),
											 lower_left_corner.y + width),
											 gradient_amount);
											
	return outer - inner;
}

void fragment()
{	
	vec2 uv = flip_y(UV);
    
	//vec3 intensity = rect_margin(uv, vec4(0.05, 0.2, 0.3, 0.5), false);
	vec3 intensity = rect_outline(uv, vec2(0.1, 0.1), vec2(0.9, 0.9), 0.3, 0.03);
	vec3 color = mix(black, white, intensity);

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