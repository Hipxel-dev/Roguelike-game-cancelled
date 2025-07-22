extends Node2D

func _ready() -> void:
	$blobs.emitting = true
	$sparks.emitting = true


func _physics_process(delta: float) -> void:
	if $blobs.emitting == false and $sparks.emitting == false:
		queue_free()
