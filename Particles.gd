extends Particles

var mat: ShaderMaterial = process_material

var pointA: Vector3
var pointB: Vector3
var pointC: Vector3

func _ready():
	pointA = mat.get_shader_param("pointA")
	pointB = mat.get_shader_param("pointB")
	pointC = mat.get_shader_param("pointC")
	emitting = true

func _process(delta: float):
	var pA = pointA
	var pB = pointB
	var pC = pointC
	
	pA.y -= sin(OS.get_ticks_msec() / 30000.0 * TAU) * 10
	pA.z -= tan(OS.get_ticks_msec() / 50000.0 * TAU) * 5
	
	pB.x += cos(OS.get_ticks_msec() / 5000.0 * TAU) * 5
	pB.y -= sin(OS.get_ticks_msec() / 10000.0 * TAU) * 5
	
	pC.x -= cos(OS.get_ticks_msec() / 20000.0 * TAU) * 5
	pC.y += sin(OS.get_ticks_msec() / 10000.0 * TAU) * 10
	pC.z += tan(OS.get_ticks_msec() / 20000.0 * TAU) * 5
	
	mat.set_shader_param("pointA", pA)
	mat.set_shader_param("pointB", pB)
	mat.set_shader_param("pointC", pC)
	
	$"../PointA".global_transform.origin = pA
	$"../PointB".global_transform.origin = pB
	$"../PointC".global_transform.origin = pC
