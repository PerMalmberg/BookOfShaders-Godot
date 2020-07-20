shader_type canvas_item;

uniform vec2 mouse = vec2(0, 0);

const vec3 colorA = vec3(0.149,0.141,0.912);
const vec3 colorB = vec3(1.000,0.833,0.224);

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

void fragment()
{	
	vec2 uv = flip_y(UV);

	vec3 weight = vec3(uv.x);

	vec3 color = mix(colorA, colorB, weight);

	weight.r = smoothstep(0.0, 1.0, uv.x);
	weight.g = sin(uv.x * pi);
	weight.b = pow(uv.x, 0.5);

	color = mix(color, vec3(1.0, 0.0, 0.0), plot(uv, weight.r, 0.02));
    color = mix(color, vec3(0.0, 1.0, 0.0), plot(uv, weight.g, 0.02));
    color = mix(color, vec3(0.0, 0.0, 1.0), plot(uv, weight.b, 0.02));

	COLOR = vec4(color, 1.0);
}
