extends Control

var delay_time = 0
var last_sh = 0

var blink_time = 0

func _physics_process(delta: float) -> void:
	if last_sh != global.shield:
		delay_time = 1
		if global.shield > last_sh:
			$shield_outline.modulate = Color(0,15,0)
			
			$sh_bar_delay.value = global.shield
			$sh_bar_lerp.value = global.shield
		else:
			blink_time = 1
			$text.modulate = Color(255,255,255)
			$shield_outline.modulate = Color(5,0,0)
			
		last_sh = global.shield
	delay_time -= delta
	
	blink_time -= delta * 3
	if blink_time > 0:
		$sh_bar_lerp.modulate = Color.transparent
		$sh_bar.modulate = Color(1,1,1,sin(OS.get_ticks_msec() * delta * 6) * 1)
		$text.modulate = Color(1,1,1,sin(OS.get_ticks_msec() * delta * 6) * 1)
	else:
		$sh_bar_lerp.modulate = Color.white
		$sh_bar.modulate = Color.white
		$text.modulate = $text.modulate.linear_interpolate(Color.white,delta * 25)

	$text.text = str(floor(global.shield))
	$text.rect_position.x = ($sh_bar.rect_position.x) + ($sh_bar_lerp.value / global.max_shield) * $sh_bar.rect_size.x
	
	$sh_bar.max_value = global.max_shield
	$sh_bar_lerp.max_value = global.max_shield
	$sh_bar_delay.max_value = global.max_shield
	
	$sh_bar.value += (global.shield - $sh_bar.value) * 0.3
	$sh_bar_lerp.value += ($sh_bar.value - $sh_bar_lerp.value) * 0.07
	if delay_time < 0:
		$sh_bar_delay.value += ($sh_bar.value - $sh_bar_delay.value) * 0.1
		$shield_outline.modulate = $shield_outline.modulate.linear_interpolate(Color.transparent,delta * 3)
	
	$sh_bar_lerp.modulate = Color(1,1,1,abs(sin(OS.get_ticks_msec() * delta * 2.2)))
