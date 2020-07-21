shader_type canvas_item;

const float pi = 3.14159265359;
const float pi_2 = pi * 2.0;

vec2 flip_y(vec2 vec)
{
	vec.y = 1.0-vec.y;
	return vec;
}

//  Function from Iñigo Quiles
//  https://www.shadertoy.com/view/MsS3Wc
vec3 hsb2rgb(in vec3 hsb)
{
	vec3 rgb = clamp(abs(mod(hsb.x * 6.0 + vec3(0.0, 4.0, 2.0), 6.0) - 3.0) - 1.0, 0.0, 1.0);
	rgb = rgb * rgb * (3.0 - 2.0 * rgb);
	return hsb.z * mix( vec3(1.0), rgb, hsb.y);
}

vec2 rotate(in vec2 original_point, in vec2 pivot, in float angle_radians)
{
	float cos_angle = cos(angle_radians);
	float sin_angle = sin(angle_radians);
	
	original_point -= pivot;
	original_point.x = original_point.x * cos_angle - original_point.y * sin_angle;
	original_point.y = original_point.x * sin_angle + original_point.y * cos_angle;
	original_point += pivot;
	return original_point;
}

void fragment()
{	
	vec2 uv = flip_y(UV);
		
	uv = rotate(uv, vec2(0.5), TIME);
	
	// Use polar coordinates instead of cartesian
    vec2 to_center = vec2(0.5) - uv;
    float angle = atan(to_center.y,to_center.x);
    float radius = length(to_center) * 2.0;

    // Map the angle (-PI to PI) to the Hue (from 0 to 1)
    // and the Saturation to the radius
	
	angle = angle / pi_2 + 0.5;
    vec3 color = hsb2rgb(vec3(angle, radius, 1.0));

    COLOR = vec4(color,1.0);
}
