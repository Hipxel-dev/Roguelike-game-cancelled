extends Camera2D

var follow = true
var pos = Vector2.ZERO
var view = true

onready var room_container_link = get_parent().get_node("room_container")
var room_bound = 0

func _physics_process(delta: float) -> void:
	if follow:
		pos = global.player_pos
	
	room_bound = room_container_link.area_size
	
	if room_container_link.current_room != null:
		pos.x = clamp(pos.x,(room_container_link.current_room.position.x - 320) ,(room_container_link.current_room.position.x + 320) )
		pos.y = clamp(pos.y,(room_container_link.current_room.position.y - 320) ,(room_container_link.current_room.position.y + 320) )
	position = position.linear_interpolate(pos,delta * 5)
	
	
	if view and gamesystem.settings.settings[21][1]:
		$view.position = $view.position.linear_interpolate(get_local_mouse_position() / 12, delta * 15)
	if gamesystem.settings.settings[14][1]:
		$view.offset = Vector2(rand_range(-global.shake,global.shake),rand_range(-global.shake,global.shake))
	else:
		$view.offset = Vector2.ZERO




