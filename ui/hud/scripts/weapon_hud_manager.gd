extends Control

onready var huds = [$wpn_gun_hud]

var current_hud_type = 0

func _physics_process(delta: float) -> void:
	for i in range(huds.size()):
		huds[i].active = false
		
	huds[current_hud_type].active = true
	
