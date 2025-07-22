extends Node2D

var weapons = get_children()
var current_weapon_index = 0
var current_weapon = null

var last_weapon_index = 0

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("scroll_down"):
		if current_weapon_index < weapons.size() - 1:
			current_weapon_index += 1
		else:
			current_weapon_index = 0
	if Input.is_action_just_pressed("scroll_up"):
		if current_weapon_index > 0:
			current_weapon_index -= 1
		else:
			current_weapon_index = weapons.size() - 1

func _physics_process(delta: float) -> void:
	weapons = get_children()
	
	if Input.is_action_just_pressed("QUICKSWITCH"):
		var last_weapon_to_change = current_weapon_index
		current_weapon_index = last_weapon_index
		last_weapon_index = last_weapon_to_change
	
#	if last_weapon_index != current_weapon_index:
#		last_weapon_index = current_weapon_index
		

	
	for i in range(weapons.size()):
		weapons[i].is_in_hand = false
		if i != current_weapon_index:
			weapons[i].scale = weapons[i].scale.linear_interpolate(Vector2.ZERO,delta * 15)
	
	current_weapon = weapons[current_weapon_index]
	current_weapon.is_in_hand = true
	current_weapon.scale = current_weapon.scale.linear_interpolate(Vector2.ONE,delta * 15)
	
	if get_local_mouse_position().x > 0:
		current_weapon.scale = Vector2(1,1)
	else:
		current_weapon.scale = Vector2(1,-1)
	current_weapon.position = Vector2(cos(get_local_mouse_position().angle()),sin(get_local_mouse_position().angle())) * 10
	current_weapon.look_at(get_global_mouse_position())
	
