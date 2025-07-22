extends Sprite

var acquired_ammo_amount = 0
var restore_all_ammo = false

func _ready() -> void:
	acquired_ammo_amount = floor(rand_range(10,80))
	
func _physics_process(delta: float) -> void:
	if global_position.distance_squared_to(global.player_pos) < 5555:
		global_position += (global.player_pos - global_position).normalized() * 8
		if global_position.distance_squared_to(global.player_pos) < 255:
			acquired_ammo_amount += (gamesystem.player.get_node("weapons").current_weapon.max_ammo) / 10
			gamesystem.player.get_node("weapons").current_weapon.ammo += acquired_ammo_amount
			
			
			queue_free()
