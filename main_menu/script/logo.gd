extends Node2D

var lines = []
var original_size = []
var original_pos = []

var count = 0

func _ready() -> void:
	for i in $render/shapes.get_children():
		lines.append(i)
		original_size.append(i.rect_size)
		original_pos.append(i.rect_position)
		i.rect_size = Vector2.ZERO
		i.rect_position += Vector2(-1,-1) * rand_range(-255,255)
		
func _physics_process(delta: float) -> void:
	
	if count < original_size.size():
		count += delta * 10 
	
	for i in range(count):
		var p = lines[i]
		p.rect_size = p.rect_size.linear_interpolate(original_size[i],delta * 5)
		p.rect_position = p.rect_position.linear_interpolate(original_pos[i],delta * 5)
		
		
