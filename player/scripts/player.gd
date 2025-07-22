extends KinematicBody2D

var movement = Vector2.ZERO
var spd = 350

#var health = 100
#var shield = 100
#
#var max_health = 100
#var max_shield = 100
var can_input = true

enum states {
	NORMAL,
	STUNNED,
}

var dead = false

func _init() -> void:
	global.player_pos = position
	gamesystem.player = self
	
func _physics_process(delta: float) -> void:
	global.player_pos = position
	gamesystem.player = self
	
	if dead:
		can_input = false
	
	if can_input:
		movement += Vector2(
			Input.get_action_strength("RIGHT") - Input.get_action_strength("LEFT"),
			Input.get_action_strength("DOWN") - Input.get_action_strength("UP")) * spd
	
		if movement.length() > spd:
			movement = movement.normalized() * spd
		
	movement /= 2
	move_and_slide(movement)

func damage(dmg = 15):
	gamesystem.damage_player(15)
	if global.health <= 0:
		dead = true
	
