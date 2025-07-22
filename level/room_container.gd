extends Node2D

var entire_map_size = Vector2(5,5)
var lines = 6
var branches = 6

var area_size = 320

var current_pos = Vector2.ZERO

var area = preload("res://level/forest_glades/forest_glades_generator.tscn")
var areas = []

var current_room = null

func _ready() -> void:
	for i in range(entire_map_size.x):
		var addor = []
		for o in range(entire_map_size.y):
			var area_inst = area.instance()
			area_inst.position = Vector2(o,i) * (area_size * 2)
			addor.append(area_inst)
			add_child(area_inst)
		areas.append(addor)
		

#var current_boundary = null
#
#var area_size = 128
#var area = preload("res://level/forest_glades/forest_glades_generator.tscn")
#
#var areas = []
#
#func _ready() -> void:
#	gamesystem.change_ost(preload("res://sfx/music/2025春M3 New Album Forest Funk EP - Album Preview.mp3"))
#	make_area_block(Vector2.ZERO,true)
#
#func make_area_block(direction = Vector2(0,0),starting_area = false):
#	var area_inst = area.instance()
#	if starting_area:
#		add_child(area_inst)
#		areas.append(area_inst)
#		current_boundary = area_inst
#	else:
#		area_inst.position = current_boundary.position + ((direction * area_size) * 2)
#		areas.append(area_inst)
#		current_boundary = area_inst
#		add_child(area_inst)
#
#func _physics_process(delta: float) -> void:
#	if global.player_pos.x > current_boundary.position.x + (area_size):
#		make_area_block(Vector2(1,0))
#	if global.player_pos.x < current_boundary.position.x - (area_size):
#		make_area_block(Vector2(-1,0))
#	if global.player_pos.y > current_boundary.position.y + (area_size):
#		make_area_block(Vector2(0,1))
#	if global.player_pos.y < current_boundary.position.y - (area_size):
#		make_area_block(Vector2(0,-1))
