extends NinePatchRect

var hovered = false
var just_hovered = false

func _on_title_mouse_entered() -> void:
	hovered = true
	
func _on_title_mouse_exited() -> void:
	hovered = false
	
func _physics_process(delta: float) -> void:
	
	if get_local_mouse_position().x > 0 and get_local_mouse_position().y > 0 and get_local_mouse_position().x < rect_size.x and get_local_mouse_position().y < rect_size.y:
		hovered = true
		if just_hovered == false:
			gamesystem.make_sfx(preload("res://sfx/ui_sfx/click_light.wav"),12,2)
			just_hovered = true
	else:
		just_hovered = false
		hovered = false
	
	if $rect.visible:
		$text.rect_position.x += (5 - $text.rect_position.x) * 0.4
		if hovered:
			self_modulate = self_modulate.linear_interpolate(Color(0.3,0.3,0.3,1),delta * 15)
			$text.rect_position.x += 2
			$text.modulate = $text.modulate.linear_interpolate(Color.white,delta * 15)
			$rect.modulate = $rect.modulate.linear_interpolate(Color(0.3,0.3,0.3,1),delta *25)
		else:
			$text.modulate = $text.modulate.linear_interpolate(Color.gray,delta * 15)
			
			self_modulate = self_modulate.linear_interpolate(Color(1,1,1,0),delta * 15)
			$rect.modulate = $rect.modulate.linear_interpolate(Color(0.0,0.0,0.0,1),delta * 25)
	else:
		$text.rect_position.x = 0
