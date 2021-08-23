extends Spatial

func _process(delta: float):
	var r = OS.get_ticks_msec() / 10000.0 * TAU - TAU / 4
	rotation.y = r
