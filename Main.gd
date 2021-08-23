extends Spatial

func _process(delta):
	var toggled_fullscreen = Input.is_action_just_pressed("toggle_fullscreen")
	if toggled_fullscreen:
		OS.window_fullscreen = not OS.window_fullscreen
