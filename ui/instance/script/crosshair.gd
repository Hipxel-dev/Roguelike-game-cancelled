extends Sprite

func _process(delta: float) -> void:
	position = get_global_mouse_position()
#	if texture != null:	
#		$outline.texture = texture
