extends Node2D

var titles = []
var buttons = []

onready var title = $title.duplicate()
onready var toggle = $toggle.duplicate()
onready var slider = $slider.duplicate()
onready var padding = $padding.duplicate()
onready var dropdown = $dropdown.duplicate()

var scroll_hover = false

var scroll = 0
var drag = 0
var dragging = false

var spacing = 16

var push = 0
var push_index = 0

func _input(event: InputEvent) -> void:
	if get_parent().current_state == get_parent().states.SETTINGS:
		if $back.clicked() or Input.is_action_just_pressed("ui_cancel"):
			get_parent().current_state = get_parent().states.MAIN
			
		for i in range(buttons.size()):
			if gamesystem.settings.settings[i].size() != 1:
				gamesystem.settings.settings[i][1] = buttons[i].value
				
		if Input.is_action_just_pressed("CLICK") or Input.is_action_just_released("CLICK"):
			ResourceSaver.save(gamesystem.settings_path,gamesystem.settings)
		
		if Input.is_action_just_pressed("scroll_down"):
			scroll += 30
		if Input.is_action_just_pressed("scroll_up"):
			scroll -= 30
	
func _ready() -> void:
	
	$title.queue_free()
	$toggle.queue_free()
	$slider.queue_free()
	$padding.queue_free()
	$dropdown.queue_free()
	
	for i in range(gamesystem.settings.settings.size()):
		var is_padding = false
		var setting_name = gamesystem.settings.settings[i][0]
		var setting_value = gamesystem.settings.settings_ui.get(gamesystem.settings.settings_ui.keys()[i])
		var setting_value_save = ""
		var setting_type = ""
		
		if gamesystem.settings.settings[i].size() != 1:
			setting_value_save = gamesystem.settings.settings[i][1]
			setting_type = gamesystem.settings.settings_ui.keys()[i][0]
		else:	
			is_padding = true
		print(str(i, " - ", setting_name, " - ", setting_type, " - ", setting_value, " - ", setting_value_save))
		
		var title_inst = title.duplicate()
		title_inst.get_node("text").text = setting_name
		titles.append(title_inst)
		$container.add_child(title_inst)
		
		if is_padding == false:
			if setting_type == "S":
				var slider_inst = slider.duplicate()
				slider_inst.value = setting_value_save
				slider_inst.max_value = setting_value[1]
				buttons.append(slider_inst)
				$container.add_child(slider_inst)
			elif setting_type == "B":
				var toggle_inst = toggle.duplicate()
				toggle_inst.value = setting_value_save
				buttons.append(toggle_inst)
				$container.add_child(toggle_inst)
			elif setting_type == "D":
				var dropdown_inst = dropdown.duplicate()
				dropdown_inst.value = setting_value_save
				dropdown_inst.lists = setting_value
				buttons.append(dropdown_inst)
				$container.add_child(dropdown_inst)
		else:
			var padding_inst = padding.duplicate()
			padding_inst.get_node("text").text = setting_value
			buttons.append(padding_inst)
			$container.add_child(padding_inst)
		
var just_entered = false

# oh fwk i have memory loss

func update_values():
	for i in range(buttons.size()):
		gamesystem.settings.settings[gamesystem.settings.settings.keys()] = buttons[i].value 

var scroll_pos = 0

func _physics_process(delta: float) -> void:
	spacing = 15
	if get_parent().current_state == get_parent().states.SETTINGS:
		position /= 1.9
		
		scroll += (clamp(scroll,0,(buttons.size() * spacing) - $container.rect_size.y) - scroll) * 0.2
		$container/scroll/ColorRect.rect_position.y = 2 + (scroll / (buttons.size() * spacing - $container.rect_size.y)) * 123.0
		
		$container/scroll/ColorRect.modulate = Color.darkgray
		if scroll_hover:
			$container/scroll/ColorRect.modulate = Color.white
			$container/scroll.rect_size.x += (10 - $container/scroll.rect_size.x) * 0.3
		else:
			$container/scroll.rect_size.x += (5 - $container/scroll.rect_size.x) * 0.3
		
		if Input.is_action_just_pressed("CLICK") and scroll_hover:
			scroll_pos = $container/scroll/ColorRect.get_local_mouse_position().y
		if Input.is_action_pressed("CLICK") and scroll_hover:
			$container/scroll/ColorRect.modulate = Color.darkgray.darkened(0.4)
			scroll_hover = true
			$container/scroll/ColorRect.rect_position.y = $container/scroll.get_local_mouse_position().y - scroll_pos
			scroll = ($container/scroll/ColorRect.rect_position.y / 123.0) * (buttons.size() * spacing - $container.rect_size.y)
			
		if Input.is_action_just_pressed("ALT_CLICK"):
			dragging = true
			drag = $container.get_local_mouse_position().y
			
		if dragging:
			scroll -= (($container.get_local_mouse_position().y - drag)) * 2
			drag = $container.get_local_mouse_position().y 
			
		if Input.is_action_just_released("ALT_CLICK"):
			dragging = false
			
			
		if just_entered == false:
			for i in range(titles.size()):
				titles[i].rect_position.x = -1000 + (-1000 * i)
			for i in range(buttons.size()):
				buttons[i].rect_position.x = 1000 + (1000 * i)
			just_entered = true
		
		for i in range(buttons.size()):
			var p = buttons[i]
			p.rect_position = p.rect_position.linear_interpolate($container/value_pos.position + Vector2(0,(i * spacing) - scroll), delta * 15)
			if p.is_in_group("padding"):
				titles[i].get_node("rect").hide()
				titles[i].self_modulate = Color.transparent
			var m = titles[i]
			m.rect_position = m.rect_position.linear_interpolate($container/name_pos.position + Vector2(0,(i * spacing) - scroll),delta * 15)
			
			if i > push_index:
				titles[i].rect_position.y += push
				buttons[i].rect_position.y += push
	
	else:
		just_entered = false
		position.x += (1200 - position.x) * 0.2


func _on_ColorRect_mouse_entered() -> void:
	scroll_hover = true
	
func _on_ColorRect_mouse_exited() -> void:
	scroll_hover = false
