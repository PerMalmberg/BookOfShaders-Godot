shader_type canvas_item;

uniform vec2 mouse = vec2(0, 0);
uniform vec2 dimension = vec2(1024, 600);

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

vec4 circle(vec2 coord, vec2 center, float radius, float gradient_amount)
{
	vec4 intensity = vec4(0.0);
	
	float dist = distance(center, coord);
		
	if (dist <= radius)
	{
		if (gradient_amount > 0.0)
		{
			float alpha = 1.0 - dist / gradient_amount;
			intensity = vec4(vec3(1.0), clamp(alpha, 0, 1.0));
		}
		else
		{
			intensity = vec4(1.0);
		}
	}	
	
	return intensity;
}

vec4 alpha_blend(vec4 color_a, vec4 color_b)
{
	return vec4(mix(color_a.rgb, color_b.rgb, color_b.a), (1.0 - (1.0 - color_a.a) * (1.0 - color_b.a)));
}

void fragment()
{	
	vec2 uv = flip_y(UV);
    
	float scaled_time = sin(TIME) / 2.0 + 0.5;

	// Larger than 0.5 radius and capped gradient amount prevents the hard outline
	vec4 color = alpha_blend(transparent, yellow * circle(uv, vec2(0.7), 0.3, min(0.2, scaled_time)));
	color = alpha_blend(color, blue * circle(uv, vec2(0.3), 0.4, min(0.4, scaled_time)));
	color = alpha_blend(color, red * circle(uv, vec2(0.5), 0.6, min(0.5, scaled_time)));
	
    COLOR = vec4(color);
}
