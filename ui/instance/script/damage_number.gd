extends Label

onready var vel = Vector2(rand_range(-50,50),rand_range(-180,-160))
var lifetime = 0.7

func _physics_process(delta: float) -> void:
	rect_position += vel * delta
	vel.y += 6
	
	lifetime -= delta
	if lifetime < 0:
		queue_free()
		
	if lifetime < 0.25:
		self_modulate = Color8(255,255,255,sin(OS.get_ticks_msec() * delta * 6) * 255)
		
