extends Node2D

var buttons = []
var texts = ["Resume", "Settings", "Quick Restart", "Quit"]

onready var button_dupe = $button.duplicate()
var selected_button = null

func _ready() -> void:
	$button.queue_free()
	for i in range(texts.size()):
		var button_inst = button_dupe.duplicate()
		button_inst.get_node("text").text = texts[i]
		buttons.append(button_inst)
		add_child(button_inst)

func _physics_process(delta: float) -> void:
	if get_parent().current_state == get_parent().states.MAIN:
		
		selected_button = null
		
		for i in range(buttons.size()):
			var p = buttons[i]
			p.rect_position = p.rect_position.linear_interpolate($anchor.position + Vector2(i * -2,i * 22),delta * 15)
			p.get_node("text").rect_position.x += (43 - p.get_node("text").rect_position.x) * 0.3
			if buttons[i].get_node("mouse_bounder").hovered:
				p.rect_position.x += 3
				selected_button = p
				p.get_node("rect").modulate = p.get_node("rect").modulate.linear_interpolate(Color.white,delta * 18)
				p.get_node("text").modulate = p.get_node("text").modulate.linear_interpolate(Color.black,delta * 18)
			else:
				p.get_node("rect").modulate = p.get_node("rect").modulate.linear_interpolate(Color.black,delta * 18)
				p.get_node("text").modulate = p.get_node("text").modulate.linear_interpolate(Color.white,delta * 18)
		
		if Input.is_action_just_pressed("CLICK"):
			for i in range(buttons.size()):
				if buttons[i].get_node("mouse_bounder").hovered:
					if i == 0:
						get_tree().paused = false
						get_parent().queue_free()
					elif i == 1:
						get_parent().current_state = get_parent().states.SETTINGS
					elif i == 2:
						get_tree().paused = false
						get_parent().queue_free()
						gamesystem.start_run()
						
						
		if selected_button != null:
			$select_fx.position = $select_fx.position.linear_interpolate(selected_button.rect_position,delta * 25)
			$select_fx.modulate = Color.white
		else:
			$select_fx.position.x -= 12
			$select_fx.position.x /= 1.1
			$select_fx.modulate = $select_fx.modulate.linear_interpolate(Color.transparent,delta * 15)

	else:
		for i in range(buttons.size()):
			var p = buttons[i]
			p.rect_position = p.rect_position.linear_interpolate($anchor.position + Vector2((i * -722) - 200,i * -222),delta * 15)
			$select_fx.modulate = Color.transparent
		
		
		
		
