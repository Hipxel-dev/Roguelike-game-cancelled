extends NinePatchRect

var lists = []

var hovered = false
var value = 0

var buttons = []
onready var btn_dupe = $drop.duplicate()

var open = false

func _ready() -> void:
	$drop.queue_free()
	for i in range(lists.size()):
		var drop_inst = btn_dupe.duplicate()
		drop_inst.get_node("text").text = lists[i]
		buttons.append(drop_inst)
		$container.add_child(drop_inst)
		
func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("CLICK"):
		open = false
		get_parent().get_parent().push = 0
		for i in range(buttons.size()):
			if buttons[i].hovered:
				value = i
		
	if hovered:
		$text.modulate = $text.modulate.linear_interpolate(Color.white,delta * 15)
	else:
		$text.modulate = $text.modulate.linear_interpolate(Color.darkgray,delta * 15)
	
	if lists != []:
		$text.text = lists[value]
	if Input.is_action_just_pressed("CLICK") and hovered:
		open = true
		get_parent().get_parent().push = (lists.size() * 2.3) + 1
		for i in range(get_parent().get_parent().buttons.size()):
			if get_parent().get_parent().buttons[i] == self:
				get_parent().get_parent().push_index = i
	if open:
		$text.hide()
		show_on_top = true
		$container.rect_size.y += (((buttons.size() * 12) + 1) - $container.rect_size.y) * 0.2
		$container.modulate = $container.modulate.linear_interpolate(Color.white,delta * 15)
		
		for i in range(buttons.size()):
			var p = buttons[i]
			p.show()
			p.rect_position = p.rect_position.linear_interpolate(Vector2(-22,i * 12),delta * 15)
			if p.hovered:
				p.rect_position.x += 1
	else:
		show_on_top = false
		$text.show()
		
		$container.rect_size.y += (0 - $container.rect_size.y) * 0.1
		$container.modulate = $container.modulate.linear_interpolate(Color.transparent,delta * 15)
		for i in buttons:
			i.hide()
			i.hovered = false
			i.rect_position.y = 0
	
func _on_dropdown_mouse_entered() -> void:
	hovered = true
	

func _on_dropdown_mouse_exited() -> void:
	hovered = false
