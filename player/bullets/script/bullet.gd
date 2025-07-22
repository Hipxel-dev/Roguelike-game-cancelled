extends Area2D

var lifetime = 2
var target = "enemy"
var movement = Vector2.ZERO

var damage = 25
var bullet_impact_fx = preload("res://effects/player/bullet_fx/bullet_impact_fx.tscn")

func _ready() -> void:
	$line.set_as_toplevel(true)

func _physics_process(delta: float) -> void:
	position += movement * delta
	lifetime -= delta
	if lifetime < 0:
		queue_free()
		
	$light2.modulate = Color(1,1,1,abs(sin(OS.get_ticks_msec() * delta * 15) * 0.2))
	$light.modulate = Color(1,1,1,abs(sin(OS.get_ticks_msec() * delta * 4) * 0.1))
	$light.scale = Vector2.ONE * sin(OS.get_ticks_msec() * delta * 15) * 0.3
	
	if $line.get_point_count() < 5:
		$line.add_point(global_position,$line.get_point_count())
	else:
		$line.remove_point(0)
	
	
		
func _on_bullet_area_entered(area: Area2D) -> void:
	if area.is_in_group(target):
		area.damage(abs(damage + floor(rand_range(0,10))))
		var bullet_impact_fx_inst = bullet_impact_fx.instance()
		bullet_impact_fx_inst.position = position
		bullet_impact_fx_inst.rotation = movement.angle()
		get_parent().add_child(bullet_impact_fx_inst)
		queue_free()
