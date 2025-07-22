extends CanvasLayer

enum states {
	MAIN,
	SETTINGS
}
var current_state = states.MAIN

func _ready() -> void:
	offset.x = -500
	get_tree().paused = true
	
func _physics_process(delta: float) -> void:
	offset.x /= 1.3
	

