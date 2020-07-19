shader_type canvas_item;


uniform vec2 mouse = vec2(100.0, 100.0);

float adjusted_sin(float v)
{
	// Adjust to 0..1 instead of -1...1
	return sin(v) / 2.0 + 0.5;
}

float adjusted_cos(float v)
{
	// Adjust to 0..1 instead of -1...1
	return cos(v) / 2.0 + 0.5;
}

//void fragment()
//{	
//	COLOR = vec4(adjusted_sin(TIME), adjusted_cos(TIME), adjusted_sin(TIME / 2.0), 1.0);
//}

//void fragment()
//{
//	// FRAGCOORD is based on screen/viewport space
//	vec2 normalized = FRAGCOORD.xy / dimension;
//	COLOR = vec4(normalized.x, normalized.y, 0, 1.0);
//}

//void fragment()
//{
//	// FRAGCOORD is based on screen/viewport space
//	vec2 normalized = mouse / dimension;
//  // Mouse coords' y-axis is fliped compared to FRAGCOORD and same as UV.
//	COLOR = vec4(normalized.x, 1.0 - normalized.y, 0, 1.0);
//}

float avg(float a, float b, float c)
{
	return (a+b+c) / 3.0;
}

void fragment()
{	
	vec2 pos = UV.xy;
	// Normalize mouse position
	vec2 m_pos = mouse / 512.0;

	float r = mix(1.0, 0.0, pos.x);
	float g = mix(1.0, 0.0, pos.y);
	float b = mix(0.0, 1.0, pos.x);
	
	float alpha = 1.0;
		
	float l = length(pos - m_pos);
	const float limit = 0.1;
	
	if (l <= limit)
	{
		alpha = mix(0, 1.0, l / limit);
	}
	
	COLOR = vec4(r, g, b, alpha);
}