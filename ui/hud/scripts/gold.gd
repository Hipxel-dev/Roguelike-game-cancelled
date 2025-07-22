extends Control

var visible_time = 3

var gold_count = 0

var last_gold = 0
var gold_add_counter = 0

func _physics_process(delta: float) -> void:
	if last_gold != global.gold:
		if global.gold > last_gold:
			gold_add_counter += global.gold - last_gold
			visible_time = 1
		last_gold = global.gold
		
	visible_time -= delta
	if visible_time < 0:
		if gold_add_counter > 0:
			gold_add_counter -= 1
			gold_count += 1
		
	if gold_add_counter > 0:
		$text2.modulate = $text2.modulate.linear_interpolate(Color.white,delta * 15)
	else:
		$text2.modulate = $text2.modulate.linear_interpolate(Color.transparent,delta * 15)
		
	$text2.text = str("+",gold_add_counter)
	$text.text = str(gold_count)
	
			
