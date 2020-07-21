shader_type canvas_item;

const float pi = 3.14159265359;
const float pi_2 = pi * 2.0;
const vec2 center = vec2(0.5);

vec2 flip_y(in vec2 vec)
{
	vec.y = 1.0-vec.y;
	return vec;
}

//  Function from Iñigo Quiles
//  https://www.shadertoy.com/view/MsS3Wc
vec3 hsb2rgb(in vec3 hsb)
{
	vec3 rgb = clamp(
					abs(
						mod(hsb.x * 6.0 + vec3(0.0, 4.0, 2.0), 6.0) - 3.0
						) - 1.0,
						0.0, 1.0);
						
	rgb = rgb * rgb * (3.0 - 2.0 * rgb);
	return hsb.z * mix( vec3(1.0), rgb, hsb.y);
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

// https://easings.net/#easeInOutQuint
float ease_in_sine(float hue_gradient)
{
	float x = hue_gradient;
	return 1.0 - cos((x * pi) / 2.0);
}

void fragment()
{	
	vec2 uv = flip_y(UV);	
	
	//uv = rotate(uv, center, TIME);
	
	// Use polar coordinates instead of cartesian
    vec2 to_center = center - uv;
    float angle = atan(to_center.y, to_center.x);
    float radius = length(to_center);

    // Map the angle (-PI to PI) to the Hue (from 0 to 1)
    // and the Saturation to the radius
	float hue = angle / pi_2 + 0.5;
	
	vec3 color = hsb2rgb(vec3(ease_in_sine(hue), radius * 2.0, 1.0));
	
	// Make it a circle
	float alpha = radius <= 0.5 ? 1.0 : 0.0;
	
    COLOR = vec4(color, alpha);
}
