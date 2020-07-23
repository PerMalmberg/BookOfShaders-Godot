shader_type canvas_item;

uniform bool show_curve = false;

const float pi = 3.14159265359;
const float pi_2 = pi * 2.0;

const vec4 red = vec4(vec3(1.0, 0, 0), 1.0);
const vec4 blue = vec4(vec3(0, 0, 1.0), 1.0);
const vec4 white = vec4(vec3(1.0), 1.0);
const vec4 black = vec4(vec3(0.0), 1.0);
const vec4 biege = vec4(vec3(247.0/255.0, 240.0/255.0, 220.0/255.0), 1.0);
const vec4 yellow = vec4(vec3(247.0/255.0, 207.0/255.0, 0), 1.0);
const vec4 transparent = vec4(0);


vec2 flip_y(vec2 vec)
{
	vec.y = 1.0-vec.y;
	return vec;
}

vec4 alpha_blend(vec4 color_a, vec4 color_b)
{
	return vec4(mix(color_a.rgb, color_b.rgb, color_b.a), (1.0 - (1.0 - color_a.a) * (1.0 - color_b.a)));
}

vec2 rotate(in vec2 original_point, in vec2 pivot, in float angle_radians)
{
	float sin_angle = sin(angle_radians);
	float cos_angle = cos(angle_radians);
	
	original_point -= pivot;
	float x = original_point.x * cos_angle - original_point.y * sin_angle;
	float y = original_point.x * sin_angle + original_point.y * cos_angle;
	return vec2(x, y) + pivot;
}

float plot(vec2 uv, float calculated_y, float line_width)
{
	float half_line_width = line_width / 2.0;
	return smoothstep(calculated_y - half_line_width, calculated_y, uv.y) 
			- smoothstep(calculated_y, calculated_y + half_line_width, uv.y);
}

// Scales the axes to fit -x_max...x_max and -y_max...y_max
void scale_axes(inout vec2 uv, in float x_max, in float y_max)
{
	uv.x = uv.x * x_max * 2.0 - x_max;
	uv.y = uv.y * y_max * 2.0 - y_max;
}

vec3 geometry(vec2 uv, vec2 pos, int corner_count)
{
	// Angle and radius from the current pixel
	float a = atan(uv.x,uv.y) + pi;
	float r = pi_2 / float(corner_count);

	// Shaping function that modulate the distance
	float d = cos(floor(0.5 + a / r) * r - a ) * length(uv);

	vec3 color = vec3(1.0 - smoothstep(0.4, 0.41, d));
	return color;
}

void fragment()
{
	vec2 uv = flip_y(UV);
    
	scale_axes(uv, 1.0, 1.0);

	vec3 color = geometry(uv, vec2(0.5), 3);

	COLOR = vec4(color, 1.0);
}

//void fragment()
//{	
//	vec2 uv = flip_y(UV);
//	float scaled_time = sin(TIME) / 2.0 + 0.5;
//
//	// Remap space to -1..1
//	uv = uv * 2.0 - 1.0;
//
//	// float d = length(abs(uv) - 0.3);
//	// float d = length( min(abs(uv) - 0.3, 0.0));
//	float d = length(max(abs(uv) - 0.3, 0.0));
//
//    //COLOR = vec4(vec3(fract(d * 10.0)), 1.0);
//
//	//COLOR = vec4(vec3(step(0.3, d)), 1.0);
//	//COLOR = vec4(vec3(step(0.3, d) * step(d, 0.4)), 1.0);
//	COLOR = vec4(vec3(smoothstep(0.3, 0.4, d) * smoothstep(0.6, 0.5, d)), 1.0);
//
//}
