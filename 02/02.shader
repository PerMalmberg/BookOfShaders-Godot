shader_type canvas_item;
uniform highp float test = 0.0;

vec4 red()
{
	return vec4(1.0, 0, 0, 1);
}

void fragment()
{	
	COLOR = red();
}

