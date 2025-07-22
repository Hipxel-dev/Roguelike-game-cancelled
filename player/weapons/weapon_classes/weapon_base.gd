extends Node2D
class_name weapon_base

export var weapon_name = "Weapon Name"
export var weapon_description = "Weapon Description"


enum types {
	SWORD,
	GUN,
	MAGIC,
	SMARTPHONE
}

func _ready() -> void:
	add_to_group("weapon")

export var current_type = types.SWORD
var is_in_hand = false

var equipped = false
var sell_value = 60

