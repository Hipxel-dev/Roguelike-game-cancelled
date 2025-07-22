extends Node2D

export var trinket_icon = preload("res://art/player/trinket/trinket_art_placeholder.png")
export var trinket_name = "A Trinket!"
export var trinket_desc = "This is a trinket"
export var trinket_desc_list = ["Makes wababom", "Maybe idk"]

var tier = 1

func _physics_process(delta: float) -> void:
	global.max_health = 50
	if tier < 0:
		global.health += 1
		tier = 2
	tier -= delta
