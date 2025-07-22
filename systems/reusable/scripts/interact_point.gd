extends Node2D

export var interact_name = "Equip Weapon"

var interacted = false
var has_been_interacted = false

func is_interacted():
	if interacted:
		interacted = false
		return true
	else:
		false

func _ready() -> void:
	add_to_group("interactable")
	
