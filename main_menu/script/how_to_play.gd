extends Node2D

onready var texts = $texts_container.get_children()

var count = 0

var just_entered = false

func _physics_process(delta: float) -> void:
	if get_parent().current_state == get_parent().states.HOW_TO_PLAY:
		position /= 1.3
		
		if $back.clicked():
			get_parent().current_state = get_parent().states.MAIN
		
		if just_entered == false:
			for i in range(texts.size()):
				texts[i].rect_position.x = -1000 + (-1000 * i)
			just_entered = true
		
		for i in range(count):
			texts[i].rect_position = texts[i].rect_position.linear_interpolate(Vector2(0,i * 12),delta * 15)
		if count < texts.size():
			count += 15 * delta
	else:
		position.x += (-500 - position.x) * 0.2
		just_entered = false
		count = 0
