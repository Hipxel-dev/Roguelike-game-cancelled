extends AnimatedSprite

var vel = Vector2.ZERO
var get_sfx = preload("res://sfx/player/objects_sfx/gold.wav")

func _ready() -> void:
	vel = Vector2(rand_range(-555,555),rand_range(-555,555))
	get_sfx = preload("res://sfx/player/weapon_reloads_sfx/pistol_reload_sfx.wav")

func _physics_process(delta: float) -> void:
	if position.distance_squared_to(global.player_pos) < 6555:
		vel += (global.player_pos - position).normalized() * 125
		
		if position.distance_squared_to(global.player_pos) < 1200:
			global.gold += 1
			gamesystem.make_sfx(get_sfx,10,rand_range(3.95,3.06))
			queue_free()
		
	position += vel * delta
	vel /= 1.3
	
