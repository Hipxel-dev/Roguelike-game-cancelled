extends Control

var delay_time = 0
var last_hp = 0

var blink_time = 0

func _physics_process(delta: float) -> void:
		
	if last_hp != global.health:
		delay_time = 1
		if global.health > last_hp:
			$health_outline.modulate = Color(0,15,0)
			
			$hp_bar_delay.value = global.health
			$hp_bar_lerp.value = global.health
		else:
			blink_time = 1
			$health_outline.modulate = Color(5,0,0)
			
		last_hp = global.health
	delay_time -= delta
	
	$text.text = str(floor(global.health))
	$text.rect_position.x = ($hp_bar.rect_position.x) + ($hp_bar_lerp.value / global.max_health) * $hp_bar.rect_size.x
	
	
	blink_time -= delta * 3
	if blink_time > 0:
		$hp_bar_lerp.modulate = Color.transparent
		$hp_bar.modulate = Color(1,1,1,sin(OS.get_ticks_msec() * delta * 6) * 1)
		$text.modulate = Color(1,1,1,sin(OS.get_ticks_msec() * delta * 6) * 1)
	else:
		$hp_bar_lerp.modulate = Color.white
		$hp_bar.modulate = Color.white
		$text.modulate = Color.white
		
	$hp_bar.max_value = global.max_health
	$hp_bar_lerp.max_value = global.max_health
	$hp_bar_delay.max_value = global.max_health
	
	$hp_bar.value += (global.health - $hp_bar.value) * 0.3
	$hp_bar_lerp.value += ($hp_bar.value - $hp_bar_lerp.value) * 0.07
	if delay_time < 0:
		$hp_bar_delay.value += ($hp_bar.value - $hp_bar_delay.value) * 0.1
		$health_outline.modulate = $health_outline.modulate.linear_interpolate(Color.transparent,delta * 3)
	
	$hp_bar_lerp.modulate = Color(1,1,1,abs(sin(OS.get_ticks_msec() * delta * 2.2)))
