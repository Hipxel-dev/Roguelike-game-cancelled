extends AudioStreamPlayer2D

func _on_sfx_finished() -> void:
	queue_free()
