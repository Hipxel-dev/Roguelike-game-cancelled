extends Node2D

func _physics_process(delta: float) -> void:
	if get_parent().current_state == get_parent().states.PRESS:
		if Input.is_action_just_pressed("ui_accept"):
			get_parent().current_state = get_parent().states.MAIN
		position /= 1.2
	else:
		position = position.linear_interpolate(Vector2(0,75),delta * 5)
