extends weapon_base
class_name weapon_gun_base

export var ammo = 460
export var max_ammo = 460
export var magazine_size = 20
export var magazine_ammo = 20

export var need_to_be_reloaded = true
export var reload_time = 0.7
export var bullet = preload("res://player/bullets/bullet.tscn")
export var bullet_speed = 700
export var bullet_spread = 50
export var ammo_consume_amount = 1
export var bullet_shoot_amount = 1
export var fire_rate = 0.17

export var full_auto = true
export var shoot_sfx = preload("res://sfx/player/weapons_sfx/guns_sfx/pistol_sfx.mp3")
export var reload_sfx = preload("res://sfx/player/weapon_reloads_sfx/pistol_reload_sfx.wav")
export var shake_amount = 2.0

var fire_rate_timer = 0
var reloading = false
var reload_timer = 0

func _init() -> void:
	current_type = 1
	reload_timer = reload_time
	
func _ready() -> void:
	pass

func _physics_process(delta: float) -> void:
	
	fire_rate_timer -= delta
	if reloading == false:
		
		if is_in_hand:
			if Input.is_action_just_pressed("RELOAD") and ammo > 0 and magazine_ammo < magazine_size:
				reloading = true
				gamesystem.make_sfx(reload_sfx)
				
			
			if full_auto:
				if Input.is_action_pressed("CLICK") and fire_rate_timer < 0:
					shoot()
			else:
				if Input.is_action_just_pressed("CLICK") and fire_rate_timer < 0:
					shoot()
	else:
		if ammo > 0:
			reload_timer -= delta
			if reload_timer < 0:
				
				if ammo >= magazine_size - magazine_ammo:
					var ammo_needed = magazine_size - magazine_ammo
					ammo -= ammo_needed
					magazine_ammo += ammo_needed
				else:
					magazine_ammo += ammo
					ammo = 0
				reload_timer = reload_time
					
				reloading = false
		else:
			reload_time = 0

func equip():
	var duplicate_self = self.duplicate()
	gamesystem.player.get_node("weapons").add_child(duplicate_self)
	queue_free()

func shoot():
	magazine_ammo -= ammo_consume_amount
	
	global.shake += shake_amount
	if magazine_ammo <= 0:
		gamesystem.make_sfx(reload_sfx)
		reloading = true
	
	for i in range(bullet_shoot_amount):
		var bullet_inst = bullet.instance()
		bullet_inst.position = global_position
		bullet_inst.movement += (get_global_mouse_position() - global_position).normalized() * bullet_speed
		bullet_inst.movement += Vector2(rand_range(-1.0,1.0),rand_range(-1.0,1.0)) * float(bullet_spread)
		bullet_inst.rotation = bullet_inst.movement.angle()
		gamesystem.main_scene.add_child(bullet_inst)
		
		gamesystem.make_sfx(shoot_sfx,0,rand_range(0.95,1.05))
		
		
	fire_rate_timer = fire_rate
	
