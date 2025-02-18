shader_type canvas_item;

uniform float amount = 40.0;

uniform float speed: hint_range(0.0,2.0,0.01) = 1.0;
uniform float intensity: hint_range(0.0,1.0,0.01) = 2.0;

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	vec2 uv = UV;
	vec3 pixel = texture(TEXTURE, uv).rgb;
	vec2 line = vec2(sin(TIME * speed) * 0.5 + 0.5, uv.y);
	vec3 glitch = texture(TEXTURE, line).rgb * intensity;
	COLOR = vec4(pixel + glitch, 0.8);
	
	
	//vec2 uv = UV*0.05;
	//float a = fract(sin(dot(UV, vec2(12.9898, 78.233) * TIME)) * 438.5453)*1.8;
	//vec4 col = texture(TEXTURE, UV);
	//col.a *= pow(a, amount);
	//COLOR.a = col.a;
}

//void light() {
	// Called for every pixel for every light affecting the CanvasItem.
	// Uncomment to replace the default light processing function with this one.
//}
