extends Area2D

var target = "player"

export var damage = 15

func _on_generic_hurter_area_entered(area: Area2D) -> void:
	if area.is_in_group("player"):
		area.damage(damage)
