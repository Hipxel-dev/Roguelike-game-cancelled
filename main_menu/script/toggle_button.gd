extends NinePatchRect

var hovered = false

var value = false
var click_sfx = preload("res://sfx/ui_sfx/click_light.wav")

func _physics_process(delta: float) -> void:

	if Input.is_action_just_pressed("CLICK") and hovered:
		value = !value
		gamesystem.make_sfx(click_sfx,15,1.5)
	
	if hovered:
		$bg.rect_scale.y += (1 - $bg.rect_scale.y) * 0.3
		$bg.rect_position.y += (3 - $bg.rect_position.y) * 0.3
		$bg.self_modulate = Color.white
	else:
		$bg.self_modulate = Color.transparent
		$bg.rect_scale.y += (1 - $bg.rect_scale.y) * 0.3
		$bg.rect_position.y += (3 - $bg.rect_position.y) * 0.3
	
	if value == true:
		$bg/toggle.rect_position.x += (14 - $bg/toggle.rect_position.x) * 0.3
		$bg/toggle.modulate = $bg/toggle.modulate.linear_interpolate(Color.white,delta * 15)
		$bg.self_modulate = $bg.self_modulate.linear_interpolate(Color.white,delta * 15)
	else:
		$bg.self_modulate = $bg.self_modulate.linear_interpolate(Color.darkgray,delta * 15)
		$bg/toggle.modulate = $bg/toggle.modulate.linear_interpolate(Color.darkgray.darkened(0.4),delta * 15)
		$bg/toggle.rect_position.x += (2 - $bg/toggle.rect_position.x) * 0.3


func _on_toggle_mouse_entered() -> void:
	hovered = true
	
func _on_toggle_mouse_exited() -> void:
	hovered = false
