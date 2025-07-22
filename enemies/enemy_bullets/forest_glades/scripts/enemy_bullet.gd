extends Area2D

var vel = Vector2.ZERO
var timer = 2

func _physics_process(delta: float) -> void:
	position += vel * delta
	
	timer -= delta
	if timer < 0:
		queue_free()


func _on_enemy_bullet_area_entered(area: Area2D) -> void:
	if area.is_in_group("player"):
		queue_free()
