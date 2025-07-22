extends Spatial

var children = []
var push = 1

func _ready() -> void:
	for i in get_children():
		if i.is_in_group("rot"):
			children.append(i)
		
func _physics_process(delta: float) -> void:
	for i in range(children.size()):
		children[i].rotation_degrees += ((Vector3.ONE * (i * 0.3)) * push) * delta
	push += (1 - push) * 0.1
	
	
