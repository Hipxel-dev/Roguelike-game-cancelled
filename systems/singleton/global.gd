extends Node

var player_pos = Vector2.ZERO

var health = 100
var max_health = 100

var shield = 50
var max_shield = 100

var shake = 0
var gold = 0

enum gamestates {
	NORMAL,
	CUTSCENE,
}
var current_gamestate = gamestates.NORMAL

func _ready() -> void:
	gamesystem

func _physics_process(delta: float) -> void:
	shake /= 1.3
	
	health = clamp(health,0,max_health)
	shield = clamp(shield,0,max_shield)

