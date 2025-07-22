extends Node2D

func _ready() -> void:
	gamesystem.main_scene = self

var pause_menu = preload("res://ui/pause_menu/pause_menu.tscn")

func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_cancel"):
		var pause_menu_inst = pause_menu.instance()
		get_parent().add_child(pause_menu_inst)
	
#	if Input.is_action_just_pressed("CLICK"):
#		gamesystem.make_damage_number("sfssg",get_local_mouse_position())
