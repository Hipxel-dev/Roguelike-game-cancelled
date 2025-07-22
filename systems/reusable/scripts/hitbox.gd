extends Area2D

export var make_damage_number = true

func damage(damage = 15):
	if make_damage_number:
		gamesystem.make_damage_number(str(damage),global_position)
	get_parent().damage(15)
