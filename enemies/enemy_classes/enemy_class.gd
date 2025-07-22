extends KinematicBody2D
class_name enemy_base

var health = 55
var active = true

var index = 0
export var gold_drop = 2

export var assume_sprite_is_there = true
var shake = 0
var bounce = 0

var ammo_crate = preload("res://player/objects/ammo_crate.tscn")

func damage(dmg = 15):
	if active:
		global_position -= (global.player_pos - global_position).normalized() * 7
		health -= dmg
		shake += 3
		get_children()[0].scale = Vector2(0.5,1.7)
		if health < 0:
			if rand_range(0,1) > 0.5:
				var ammo_crate_inst = ammo_crate.instance()
				ammo_crate_inst.position = position
				get_parent().add_child(ammo_crate_inst)
			get_parent().remove_enemy_list(index)
			queue_free()
			global.shake += 5
			for i in range(gold_drop):
				gamesystem.make_gold(global_position)
		modulate = Color.red
	
func _physics_process(delta: float) -> void:
	if active:
		shake /= 1.2
		get_children()[0].position = Vector2(rand_range(-shake,shake),rand_range(-shake,shake))
		get_children()[0].scale = get_children()[0].scale.linear_interpolate(Vector2.ONE,delta * 19)
		modulate = modulate.linear_interpolate(Color.white,delta * 15)
		
		global_position += (global.player_pos - global_position).normalized() * 1
		
