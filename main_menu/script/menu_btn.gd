extends NinePatchRect

var hovered = false

func _physics_process(delta: float) -> void:
	if hovered:
		$rect.modulate = $rect.modulate.linear_interpolate(Color.red,delta * 15)
		self_modulate = self_modulate.linear_interpolate(Color.white,delta * 15)
		
		$text.rect_position.x += (10 - $text.rect_position.x) * 0.2
	else:
		$text.rect_position.x += (4 - $text.rect_position.x) * 0.2
		
		$text.modulate = $text.modulate.linear_interpolate(Color.white,delta * 15)
		$rect.modulate = $rect.modulate.linear_interpolate(Color.black,delta * 15)
		self_modulate = self_modulate.linear_interpolate(Color.transparent,delta * 15)
