extends NinePatchRect
class_name button

var hovered = false
onready var rect = $ColorRect

onready var children = get_children()
export var clickable = true

export var hover_color = Color.white
export var unhover_color = Color.black

export var child_hover_color = Color.black
export var child_unhover_color = Color.white

var just_hovered = false

var modulate_timer = 1
export var hover_sfx = preload("res://sfx/ui_sfx/click_light.wav")
export var hover_pit = 5

export var click_sfx = preload("res://sfx/ui_sfx/click_light.wav")
export var click_pit = 2


func _ready() -> void:
	children.pop_front()

func _physics_process(delta: float) -> void:
	modulate_timer -= delta
	
	if clickable == false:
		hovered = false
	
	if hovered:
		if Input.is_action_just_pressed("CLICK"):
			$ColorRect/click_sfx.stream = click_sfx
			$ColorRect/click_sfx.pitch_scale = click_pit
			$ColorRect/click_sfx.play()
		rect.modulate = rect.modulate.linear_interpolate(hover_color,delta * 15)
		if modulate_timer > 0:
			for i in children:
				i.modulate = i.modulate.linear_interpolate(child_hover_color,delta * 15)
	else:
		rect.modulate = rect.modulate.linear_interpolate(unhover_color,delta * 15)
		if modulate_timer > 0:
			for i in children:
				i.modulate = i.modulate.linear_interpolate(child_unhover_color,delta * 15)
	
	
		
func clicked():
	if Input.is_action_just_pressed("CLICK") and hovered:
		return true
	else:
		return false
		
func clicked_release():
	if Input.is_action_just_released("CLICK") and hovered:
		return true
	else:
		return false
		
func clicked_hold():
	if Input.is_action_released("CLICK") and hovered:
		return true
	else:
		return false

func _on_Control_mouse_entered() -> void:
	hovered = true
	modulate_timer = 1
	$ColorRect/hover_sfx.stream = hover_sfx
	$ColorRect/hover_sfx.pitch_scale = hover_pit
	$ColorRect/hover_sfx.play()
	
func _on_Control_mouse_exited() -> void:
	hovered = false
	modulate_timer = 1
