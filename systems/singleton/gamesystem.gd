extends Node2D

var settings = preload("res://systems/persistent/settings.tres")
var settings_path = "user://settings.tres"

var player = null
var main_scene = null
var trinket_hud = null

var current_ost = preload("res://sfx/music/BMS - Laplace  削除  140.mp3")
var ost_node = null

var sfx_scene = preload("res://systems/reusable/sfx.tscn")
var crosshair = preload("res://ui/instance/crosshair_plane.tscn")

func change_ost(to_what = null):
	if to_what != null:
		current_ost = to_what
	if ost_node == null:
		var music_player = AudioStreamPlayer.new()
		music_player.stream = current_ost
		music_player.play()
		ost_node = music_player
		add_child(ost_node)
	else:
		ost_node.stream = current_ost
		ost_node.play()
		
var crosshairs = [
	preload("res://art/ui_art/cursors/crosshair1.png"),
	preload("res://art/ui_art/cursors/crosshair2.png"),
	preload("res://art/ui_art/cursors/crosshair3.png"),
	preload("res://art/ui_art/cursors/crosshair4.png"),
	preload("res://art/ui_art/cursors/crosshair5.png"),
	preload("res://art/ui_art/cursors/crosshair6.png"),
	preload("res://art/ui_art/cursors/crosshair7.png"),
	preload("res://art/ui_art/cursors/crosshair8.png"),
	preload("res://art/ui_art/cursors/crosshair9.png"),
	preload("res://art/ui_art/cursors/crosshair10.png"),
]

func damage_player(dmg = 15):
	var reduced_dmg = dmg - (global.shield / global.max_shield) * dmg
	reduced_dmg = clamp(reduced_dmg,1,INF)
	global.health -= floor(reduced_dmg)
	global.shield -= floor(dmg / 4)
	gamesystem.make_damage_number(str(floor(reduced_dmg)),global.player_pos)
	

func give_trinket(what_trinket = preload("res://player/trinkets/test_trinket.tscn")):
	var trinket_inst = what_trinket.instance()
	if player != null:
		player.get_node("trinkets").add_child(trinket_inst)
	trinket_hud.insert_trinket_icon(trinket_inst)

var gold = preload("res://player/objects/gold.tscn")
func make_gold(pos):
	var gold_inst = gold.instance()
	gold_inst.global_position = pos
	add_child(gold_inst)
	
#	var shield_factor = global.shield / global.max_shield
#	var reduced_dmg = float(dmg) - (float(shield_factor) * (float(dmg) / 1.1))
#	global.health -= reduced_dmg
#	gamesystem.make_damage_number(str(reduced_dmg),global.player_pos)
#	global.shield -= dmg / 5
#	global.shield = clamp(global.shield,0,global.max_shield)
#	global.health = clamp(global.health,0,global.max_health)

func manage_game_by_config():
	if ost_node != null:
		ost_node.volume_db = ((settings.settings[1][1] / 100.0) * 60.0) - 60
#
	OS.window_fullscreen = settings.settings[6][1]
	OS.vsync_enabled = settings.settings[5][1]
	
	if settings.settings[9][1] != 0:
		ProjectSettings.set("display/mouse_cursor/custom_image_hotspot",36)
		crosshair.get_node("crosshair").texture = crosshairs[settings.settings[9][1] - 1]
		crosshair.get_node("crosshair").scale = Vector2(0.5,0.5) * (settings.settings[10][1] + 1)
		crosshair.get_node("crosshair").material.set_shader_param("width", settings.settings[11][1])
		Input.set_custom_mouse_cursor(preload("res://art/ui_art/cursors/nothing.png"))
	else:
		crosshair.get_node("crosshair").texture = null
		Input.set_custom_mouse_cursor(null)
		
		
		
var dmg_number = preload("res://ui/instance/damage_number.tscn")

func make_damage_number(txt = "text",pos = global.player_pos,color = Color.white):
	var dmg_number_inst = dmg_number.instance()
	dmg_number_inst.rect_position = pos 
	dmg_number_inst.text = txt
	dmg_number_inst.modulate = color
	add_child(dmg_number_inst)

func _ready() -> void:
	z_index = 55
	pause_mode = Node.PAUSE_MODE_PROCESS
	change_ost()
	load_settings()
	setup_crosshair()
	
func setup_crosshair():
	var crosshair_plane_inst = crosshair.instance()
	add_child(crosshair_plane_inst)
	crosshair = crosshair_plane_inst

func load_settings():
	if ResourceLoader.load(settings_path) == null:
		ResourceSaver.save(settings_path, settings)
	else:
		settings = ResourceLoader.load(settings_path)

func _physics_process(delta: float) -> void:
	manage_game_by_config()

func make_sfx(sfx = preload("res://sfx/ui_sfx/check-on.wav"),vol = 0,pit = 1):
	var sfx_inst = sfx_scene.instance()
	sfx_inst.stream = sfx 
	sfx_inst.volume_db = ((settings.settings[2][1] / 70) * 100) - 100
	sfx_inst.pitch_scale = pit
	sfx_inst.position = global.player_pos
	add_child(sfx_inst)
	

func start_run():
	global.health = global.max_health
	global.shield = global.max_shield
	global.gold = 0
	
	get_tree().change_scene("res://level/main_scene.tscn")

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("FULLSCREEN"):
		OS.window_fullscreen = !OS.window_fullscreen

func manage_window():
	pass
