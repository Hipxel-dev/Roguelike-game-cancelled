extends Node2D

var ms = Vector2.ZERO
var hover = true

func _physics_process(delta: float) -> void:
	if get_parent().active:
		$rect/select_ui.rect_size = $rect.rect_size
		
		if get_parent().selected_button == null:
			$rect/title.position.x += (0 - $rect/title.position.x) * 0.2
			$rect/select_ui.modulate = Color.transparent
			$rect/select_ui.hide()
			$rect/TextureRect.rect_position.x += (((get_local_mouse_position().x / 10) - $rect/TextureRect.rect_size.x / 3) - $rect/TextureRect.rect_position.x) * 0.1
		else:
			if get_parent().selected_button == self:
				$rect/title.position.x += (10 - $rect/title.position.x) * 0.2
				$rect/select_ui.show()
				
				$rect/TextureRect.rect_position.x += (-15 - $rect/TextureRect.rect_position.x) * 0.1
				$rect/TextureRect.rect_position.x += get_local_mouse_position().x / 270
			
				if $rect/select_ui/enter.clicked():
					gamesystem.start_run()
		
		
