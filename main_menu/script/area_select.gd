extends Node2D


onready var buttons = [$area_button, $area_button2, $area_button3, $area_button4]
var active = false

var selected_button = null
var selected_build = 0

onready var class_select = $class_select.duplicate()
var class_select_inst = null

func _ready() -> void:
	$class_select.queue_free()

func _input(event: InputEvent) -> void:
	for i in buttons:
		if i.get_node("rect").clicked():
			selected_button = i
			selected_button.get_node("rect").clickable = false
			var class_select_dupe = class_select.duplicate()
			class_select_inst = class_select_dupe
			selected_button.add_child(class_select_dupe)
	
func _physics_process(delta: float) -> void:
	if get_parent().current_state == get_parent().states.AREA_SELECT:
		active = true
		position /= 1.2
		
		if selected_button == null:
			if $back.clicked():
				get_parent().current_state = get_parent().states.MAIN
			for i in range(buttons.size()):
				buttons[i].modulate = buttons[i].modulate.linear_interpolate(Color.white,delta * 10)
				buttons[i].get_node("rect").rect_size.x += (76 - buttons[i].get_node("rect").rect_size.x) * 0.2 
				buttons[i].position = buttons[i].position.linear_interpolate($anchor.position + Vector2(100 * i,0),delta * 15)
				if buttons[i].get_node("rect").hovered:
					buttons[i].position.x -= 3
					buttons[i].get_node("rect").rect_size.x += 5
		else:
			for i in range(buttons.size()):
				if buttons[i] != selected_button:
					buttons[i].modulate = buttons[i].modulate.linear_interpolate(Color.transparent,delta * 20)
					buttons[i].get_node("rect").rect_size.x /= 1.3
					buttons[i].position = buttons[i].position.linear_interpolate($anchor.position + Vector2(100 * i,0),delta * 5)
			
			selected_button.position.x /= 1.2
			selected_button.get_node("rect").rect_size.x += (480 - selected_button.get_node("rect").rect_size.x) * 0.2
			if $back.clicked():
				selected_button.get_node("rect").clickable = true
				selected_button = null
				class_select_inst.queue_free()
				class_select_inst = null
		
	else:
		position.y += (450 - position.y) * 0.2
		for i in range(buttons.size()):
			buttons[i].position = buttons[i].position.linear_interpolate($anchor.position + Vector2(100 * i,1000 + (i * 1000)),delta * 15)
		active = false
