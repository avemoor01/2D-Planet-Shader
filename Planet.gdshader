shader_type canvas_item;

uniform sampler3D noise;
uniform float angle;
uniform float zoom = 5.0;

const int width = 320;
const int height = 180;
const float p_radius = float(width/4);
const float brightness = 1.0;
const float magnitude = 1.0;


void fragment() {
	float dx = -(float(width/2) - VERTEX.x) / p_radius;
	float dy = -(float(height/2) - VERTEX.y) / p_radius;
	float dz = sqrt(1.0 - pow(dx, 2.0) - pow(dy, 2.0));
	vec3 pvec = vec3(dx, dy, dz);
	mat3 rotation_matrix = mat3(
		vec3(cos(angle), 0, -sin(angle)),
		vec3(0, 1, 0),
		vec3(sin(angle), 0, cos(angle))
	);
	pvec = pvec * rotation_matrix;
	pvec = vec3(pvec.x/2.0 + 0.5, pvec.y/2.0 + 0.5, pvec.z/2.0 + 0.5);
	vec4 offset = texture(noise, vec3(abs(pvec.x), abs(pvec.y), abs(pvec.z)));
	if (sqrt(pow(dx, 2.0) + pow(dy, 2.0)) <= 1.0) {
		//COLOR = vec4(abs(offset.x), abs(offset.y), abs(offset.z), 1);
		vec3 depth = vec3(abs(offset.x) * magnitude, abs(offset.y) * magnitude, abs(offset.z) * magnitude);
		if (sqrt(pow(depth.x, 2.0) + pow(depth.y,2.0) + pow(depth.z, 2.0)) > 0.8) {
			COLOR = vec4(0.2, 0.8, 0.1, 1);
		}
	} else {
		COLOR = vec4(0, 0, 0, 1);
	}	
}

//void light() {
	// Called for every pixel for every light affecting the CanvasItem.
	// Uncomment to replace the default light processing function with this one.
//}
