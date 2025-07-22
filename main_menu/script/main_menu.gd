extends Node2D

enum states {
	PRESS,
	MAIN,
	HOW_TO_PLAY,
	AREA_SELECT,
	SETTINGS
}
var current_state = states.PRESS

func _ready() -> void:
	gamesystem
	global

func _physics_process(delta: float) -> void:
	$fadeout.modulate = $fadeout.modulate.linear_interpolate(Color(0,0,0,0),delta * 1)
