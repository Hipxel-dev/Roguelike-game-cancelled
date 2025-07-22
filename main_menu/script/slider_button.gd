extends NinePatchRect

var hovered = false
var dragged = false

var value = 0
var max_value = 5

var bar_value = 0
var bar_max_value = 120

var last_value = 0

func _ready() -> void:
#	value = floor(($value.get_local_mouse_position().x / bar_max_value) * max_value)
#	value = clamp(value,0,max_value)
	value = floor((value / max_value) * max_value)
	bar_value = floor((value / max_value) * bar_max_value)
	$bg/value.rect_size.x = bar_value
	
func _draw() -> void:
	if max_value < 30:
		for i in range(max_value):
			var val = (i * $bg.rect_size.x) / max_value 
			draw_line($bg.rect_position + Vector2(val,0), $bg.rect_position + Vector2(val,7),Color.black,1)
		
var click_sfx = preload("res://sfx/ui_sfx/click_light.wav")
	
func _physics_process(delta: float) -> void:
	update()
	if hovered:
		if Input.is_action_just_pressed("CLICK"):
			dragged = true
		$bg.rect_scale.y += (0.6 - $bg.rect_scale.y) 
		$bg.rect_position.y = 5
	else:
		$bg.rect_position.y = 6
		
		$bg.rect_scale.y += (0.4 - $bg.rect_scale.y) 
	$text.text = str(value)
	
	if last_value != value:
		gamesystem.make_sfx(click_sfx,13,1.5)
		last_value = value
	
	if dragged:
		value = floor((($bg/value.get_local_mouse_position().x + ($bg.rect_size.x / max_value) ) / bar_max_value) * max_value)
		value = clamp(value,0,max_value)
		bar_value = floor((value / max_value) * bar_max_value)
	$bg/value.rect_size.x += (bar_value - $bg/value.rect_size.x) * 0.3
		
	if Input.is_action_just_released("CLICK"):
		dragged = false

func _on_slider_mouse_entered() -> void:
	hovered = true
	

func _on_slider_mouse_exited() -> void:
	hovered = false
