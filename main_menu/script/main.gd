extends Node2D

onready var buttons = [$play, $settings, $how_to_play, $quit]
var index = 0

onready var logo = get_parent().get_node("logo")

func _physics_process(delta: float) -> void:
	if get_parent().current_state == get_parent().states.MAIN:
		show()
		for i in range(buttons.size()):
			buttons[i].rect_position = buttons[i].rect_position.linear_interpolate($anchor.position + Vector2(0,i * 19),delta * 15)
			
			var ms_pos = buttons[i].get_local_mouse_position()
			if ms_pos.x > 0 and ms_pos.y > 0 and ms_pos.x < buttons[i].rect_size.x and ms_pos.y < buttons[i].rect_size.y:
				buttons[i].hovered = true
				if Input.is_action_just_pressed("CLICK"):
					if i == 0:
						get_parent().current_state = get_parent().states.AREA_SELECT
					if i == 1:
						get_parent().current_state = get_parent().states.SETTINGS
					if i == 2:
						get_parent().current_state = get_parent().states.HOW_TO_PLAY
			else:
				buttons[i].hovered = false
	
	else:
		for i in range(buttons.size()):
			buttons[i].rect_position.x = -1000 + (-1000 * i)
		hide()
		
		
