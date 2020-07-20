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

float ease_in_quint(float progress)
{
	return pow(progress, 5);
}

float ease_out_elastic(float progress)
{
	float c4 = (2.0 * pi) / 3.0;

	if (progress == 0.0)
	{		
  		return 0.0;
	}
  	else if(progress == 1.0)
	{
		return 1.0;	
	}
  	
	return pow(2.0, -10.0 * progress) * sin((progress * 10.0 - 0.75) * c4) + 1.0;
}

void fragment()
{	
	vec3 color = vec3(0.0);
	
	float weight = ease_in_quint(abs(sin(TIME)));
	color = mix(colorA, colorB, weight);
	
	COLOR = vec4(color, 1.0);
}