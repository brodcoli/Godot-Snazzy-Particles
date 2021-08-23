shader_type particles;

uniform vec3 pointA = vec3(0.0, 0.0, 10.0);
uniform vec3 pointB = vec3(10.0, 0.0, -10.0);
uniform vec3 pointC = vec3(-10.0, -10.0, -5.0);

uniform float initial_force = 10.0;
uniform float initial_spawn_area = 3.0;
uniform float gravity = 5.0;

float rand_from_seed(in uint seed) {
  int k;
  int s = int(seed);
  if (s == 0)
    s = 305420679;
  k = s / 127773;
  s = 16807 * (s - k * 127773) - 2836 * k;
  if (s < 0)
    s += 2147483647;
  seed = uint(s);
  float r = float(seed % uint(65536)) / 65535.0;
  return r * 2.0 - 1.0;
}

uint hash(uint x) {
	x = ((x >> uint(16)) ^ x) * uint(73244475);
	x = ((x >> uint(16)) ^ x) * uint(73244475);
	x = (x >> uint(16)) ^ x;
	return x;
}

void vertex(){
	if(RESTART){
		uint alt_seed = hash(uint(INDEX) + uint(1) + RANDOM_SEED);
		uint alt_seed_2 = hash(uint(INDEX) + uint(27) + RANDOM_SEED);
		uint alt_seed_3 = hash(uint(INDEX) + uint(43) + RANDOM_SEED);
	
		vec3 position = vec3(rand_from_seed(alt_seed), rand_from_seed(alt_seed_2), rand_from_seed(alt_seed_3)) * initial_spawn_area;
		TRANSFORM[3].xyz = position;
		VELOCITY = vec3(0.0, -1.0, 0.0) * initial_force;
	}else{
		vec3 v = pointA - TRANSFORM[3].xyz;
		vec3 v2 = pointB - TRANSFORM[3].xyz;
		vec3 v3 = pointC - TRANSFORM[3].xyz;
		
		vec3 dir = normalize(v);
		vec3 dir2 = normalize(v2);
		vec3 dir3 = normalize(v3);
		
		float len = length(v);
		float len2 = length(v2);
		float len3 = length(v3);
		
		vec3 f = ((dir * (1.0 / len)) + (dir2 * (1.0 / len2)) + (dir3 * (1.0 / len3))) / 3.0;
		
		VELOCITY += f * gravity;
	}
	
	COLOR = vec4(1.0, 1.0, 1.0, 1.0);
}