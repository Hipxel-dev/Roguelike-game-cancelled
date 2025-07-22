extends Node2D

var mapsize = 320
var entered = false
var just_entered = false
var just_cleared = false

var enemies = [preload("res://enemies/forest_glades_enemies/hoppus.tscn"),preload("res://enemies/forest_glades_enemies/shootus.tscn")]
onready var enemy_amount = rand_range(6,32)
var enemy_clear_fx = preload("res://effects/rewarding_visual/enemy_cleared.tscn")
var enemies_in_scene = []

var rewards = [preload("res://player/objects/stat_upgrade.tscn")]

func remove_enemy_list(idx = 0):
	var amount_of_enemies = []
	
	for i in range(enemies_in_scene.size()):
		if is_instance_valid(enemies_in_scene[i]):
			amount_of_enemies.append(enemies_in_scene[i])
	
	if amount_of_enemies.size() == 1:
		gamesystem.give_trinket()
		var enemy_clear_inst = enemy_clear_fx.instance()
		enemy_clear_inst.global_position = global.player_pos
		get_parent().add_child(enemy_clear_inst)
		
#	enemies_in_scene.pop_at(idx)
	
#	for i in range(enemies_in_scene.size()):
#		enemies_in_scene[i].index = i

func is_bound():
	if global.player_pos.x > position.x - mapsize and global.player_pos.x < position.x + mapsize and global.player_pos.y > position.y - mapsize and global.player_pos.y < position.y + mapsize:
		return true
	else:
		return false

var clear_fx = preload("res://effects/rewarding_visual/enemy_cleared.tscn")

func _physics_process(delta: float) -> void:
	if is_bound():
		show()
		if entered == false:
			generate()
			entered = true
			
		if just_entered == false:
			for i in enemies_in_scene:
				if is_instance_valid(i):
					i.active = true
			just_entered = true
		get_parent().current_room = self
	else:
		hide()
		if just_entered == true:
			for i in enemies_in_scene:
				if is_instance_valid(i):
					i.active = false
			just_entered = false

var decor_tiles = 22

func generate():
	if entered == false:
		for i in range(enemy_amount):
			var enemy_inst = enemies[rand_range(0,enemies.size())].instance()
			enemy_inst.position = Vector2(rand_range(-mapsize,mapsize),rand_range(-mapsize,mapsize)) / 1.3
			enemy_inst.index = i
			enemies_in_scene.append(enemy_inst)
			add_child(enemy_inst)

		$tile.clear()
		$decor.clear()

		var cell = mapsize / 8
		var cell16 = mapsize / 8


		for o in range(cell):
			for i in range(cell):
				$tile.set_cell(o - (cell16 / 2),i - (cell16 / 2),floor(rand_range(0,3)))
		
		for i in range(355):
			var pos = Vector2(floor(rand_range(-cell16,cell16)),floor(rand_range(-cell16,cell16)))
			$decor.set_cell(pos.x,pos.y,floor(rand_range(0,decor_tiles)))

			# make random patches
#			if rand_range(0,1) > 0.8:
#				var rand_pos = Vector2(floor(rand_range(-cell ,cell )),floor(rand_range(-cell ,cell )))
#				for o in range(15):
#					$decor.set_cell(rand_pos.x + floor(rand_range(-5,5)),rand_pos.y + floor(rand_range(-5,5)),floor(rand_range(0,decor_tiles)))

#		$tile.set_cell(pos.x,pos.y,0)

#var decor_tiles = 18
#var mapsize_x = 40
#var mapsize_y = 40
#
#var setdressings = []
#
#func _ready() -> void:
#	generate()
#
#func _physics_process(delta: float) -> void:
#	pass
#
#func generate():
#	$tile.clear()
#	$decor.clear()
#
#	for o in range(mapsize_x):
#		for i in range(mapsize_y):
#			$tile.set_cell(o,i,floor(rand_range(0,3)))
#
#	for i in range(255):
##		var pos = Vector2(floor(rand_range(-0,65)),floor(rand_range(-0,65)))
##		$decor.set_cell(pos.x,pos.y,floor(rand_range(0,decor_tiles)))
#
#		# make random patches
#		if rand_range(0,1) > 0.8:
#			var rand_pos = Vector2(floor(rand_range(-0,65)),floor(rand_range(-0,65)))
#			for o in range(15):
#				$decor.set_cell(rand_pos.x + floor(rand_range(-5,5)),rand_pos.y + floor(rand_range(-5,5)),floor(rand_range(0,decor_tiles)))
#
##		$tile.set_cell(pos.x,pos.y,0)
#
#func make_setdressings():
#	for i in range(55):
#		pass
#
		
