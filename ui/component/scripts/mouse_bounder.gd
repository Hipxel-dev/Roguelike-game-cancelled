extends Control

var hovered = false

func _input(event: InputEvent) -> void:
	if get_local_mouse_position().x > 0 and get_local_mouse_position().y > 0 and get_local_mouse_position().x < rect_size.x  and get_local_mouse_position().y < rect_size.y:
		hovered = true
	else:
		hovered = false
