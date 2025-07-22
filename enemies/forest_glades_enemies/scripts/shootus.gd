extends enemy_base

var shoot_timer = 6
var move_timer = 3

var destination = Vector2.ZERO
var vel = Vector2.ZERO

var bullet = preload("res://enemies/enemy_bullets/forest_glades/enemy_bullet.tscn")

func _ready() -> void:
	destination = position

func _physics_process(delta: float) -> void:
	
	if active:
		move_timer -= delta
		if move_timer < 0:
			destination += (global.player_pos - global_position).normalized() * 55
			destination += Vector2(rand_range(-1.0, 1.0), rand_range(-1.0,1.0)).normalized() * 74
			move_timer = rand_range(0.5,2)
			
		vel += (destination - position) * 0.3
		position += vel * delta
		vel /= 1.2
		
		if global_position.distance_squared_to(global.player_pos) < 52222:
			modulate = Color.yellow
			shoot_timer -= delta
			if shoot_timer < 0:
				var bullet_inst = bullet.instance()
				bullet_inst.position = position
				bullet_inst.vel = (global.player_pos - global_position).normalized() * 250
				get_parent().add_child(bullet_inst)
				shoot_timer = 1
			
		
