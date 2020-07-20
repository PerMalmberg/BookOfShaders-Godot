shader_type canvas_item;

uniform vec2 dimension = vec2(100.0, 100.0);
uniform vec2 mouse = vec2(0, 0);

vec2 flip_y(vec2 vec)
{
	vec.y = 1.0-vec.y;
	return vec;
}

const float pi = 3.14159265359;
const float pi_2 = pi * 2.0;
const vec3 red = vec3(1.0, 0, 0);


float plot(vec2 uv, float calculated_y, float line_width)
{
	float half_line_width = line_width / 2.0;
	return smoothstep(calculated_y - half_line_width, calculated_y, uv.y) 
			- smoothstep(calculated_y, calculated_y + half_line_width, uv.y);
}

//void fragment()
//{	
//	vec2 st = flip_y(UV.xy);
//
//	// Linear y of x
//	float y = st.x;
//
//	// Gradient
//	vec3 color = vec3(y);
//
//	float pct = plot(st, y);
//	color = (1.0-pct)*color+pct*vec3(0.0, 1.0, 0.0);
//
//	COLOR = vec4(color, 1.0);
//}

void fragment()
{	
	vec2 uv = flip_y(UV.xy);
	float x = uv.x;

	float y = sin(uv.x * 2.0 * pi_2) / 2.0 + 0.5;
	//float y = step(0.8, st.x);	
	//float y = smoothstep(0.2,0.5,st.x) - smoothstep(0.5,0.8,st.x);
	
	//y = mod(x,0.5); // return x modulo of 0.5
	//y = fract(x); // return only the fraction part of a number
	//y = ceil(x);  // nearest integer that is greater than or equal to x
	//y = floor(x); // nearest integer less than or equal to x
	//y = sign(x);  // extract the sign of x
	//y = abs(x);   // return the absolute value of x
	//y = clamp(x,0.0,1.0); // constrain x to lie between 0.0 and 1.0
	//y = min(0.0,x);   // return the lesser of x and 0.0
	//y = max(0.0,x);   // return the greater of x and 0.0 
	
	// Gradient based on y
	vec3 background = vec3(y);
	
	float point_intensity = plot(uv, y, 0.005);
	vec3 point_color = point_intensity * red;
	vec3 color = background + point_color;
	
	COLOR = vec4(color, 1.0);
}