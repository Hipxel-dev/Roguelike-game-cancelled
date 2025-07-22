extends Control

var current_weapon = null
var active = false

func _ready() -> void:
	pass

func _draw() -> void:
	if active:
		$weapon_sprite.texture = current_weapon.get_children()[0].texture
		$weapon_name.text = current_weapon.weapon_name
		
		$ammo_bar_bg.rect_size.y += ( ((current_weapon.magazine_size * 2) + 2) - $ammo_bar_bg.rect_size.y ) * 0.2
		$ammo_bar_bg/ammo_bar_outline.rect_size.y = $ammo_bar_bg.rect_size.y + 2
		for i in range(current_weapon.magazine_size):
			draw_line($ammo_bar_bg/line_pos.global_position + Vector2(0,i * -2),$ammo_bar_bg/line_pos.global_position + Vector2(5,i * -2),Color.red,1)
		for i in range(current_weapon.magazine_ammo):
			draw_line($ammo_bar_bg/line_pos.global_position + Vector2(0,i * -2),$ammo_bar_bg/line_pos.global_position + Vector2(5,i * -2),Color.white,1)
		
		if ((float(current_weapon.magazine_ammo) / float(current_weapon.magazine_size)) * 100.0) < 30:
			$ammo_dongle/magazine_ammo.modulate += (Color.red - $ammo_dongle/magazine_ammo.modulate) * 0.2
		else:
			$ammo_dongle/magazine_ammo.modulate += (Color.white - $ammo_dongle/magazine_ammo.modulate) * 0.1
			
		
		$ammo_dongle/ammo.text = str(current_weapon.ammo)
		$ammo_dongle/magazine_ammo.text = str(current_weapon.magazine_ammo)

		if current_weapon.reloading:
			if current_weapon.ammo > 0:
				$ammo_dongle.rect_position = Vector2($ammo_bar_bg/line_pos.global_position.x + 5,$ammo_bar_bg/line_pos.global_position.y + ((current_weapon.reload_time - current_weapon.reload_timer) / current_weapon.reload_time ) * (current_weapon.magazine_size * -2) - 0)
				
#				$ammo_dongle.rect_position += ($ammo_bar_bg/line_pos.global_position - $ammo_dongle.rect_position) * 0.2
				$ammo_dongle.rect_position.x += 1
				$ammo_dongle/reloading_bar.show()
				$ammo_dongle/reloading_bar/progress.max_value = current_weapon.reload_time
				$ammo_dongle/reloading_bar/progress.value = (current_weapon.reload_time - current_weapon.reload_timer)
				draw_line($ammo_bar_bg/line_pos2.global_position , $ammo_bar_bg/line_pos2.global_position + Vector2(0,((current_weapon.reload_time - current_weapon.reload_timer) / current_weapon.reload_time ) * (current_weapon.magazine_size * -2) - 5),Color.white,1)
				$ammo_dongle/reloading_bar/text.text = "reloading"
		else:
			$ammo_dongle.rect_position += (($ammo_bar_bg/line_pos.global_position - Vector2(0, (current_weapon.magazine_ammo * 2) - 3)) - $ammo_dongle.rect_position) * 0.4
			$ammo_dongle/reloading_bar.hide()
		
		if current_weapon.ammo <= 0 and current_weapon.magazine_ammo <= 0:
			$ammo_dongle/reloading_bar.show()
			$ammo_dongle/reloading_bar/text.text = "empty"
			$ammo_dongle.rect_position = $ammo_bar_bg/line_pos.global_position
func _physics_process(delta: float) -> void:
	if active:
		current_weapon = gamesystem.player.get_node("weapons").current_weapon
		update()
		
