extends CanvasLayer

onready var huds = get_children()

func _physics_process(delta: float) -> void:
	for i in huds:
		i.modulate = Color8(255,255,255,gamesystem.settings.settings[7][1])
