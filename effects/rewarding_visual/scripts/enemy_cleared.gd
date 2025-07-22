extends Node2D

var width = 277
var size = 2

var modulat = Color.white
var timer = 1

var throwaway_val = 0
var throwaway_val1 = 0
var throwaway_val2 = 0
var throwaway_val3 = 0

func _draw() -> void:
	
	draw_arc(Vector2.ZERO,size,-PI,PI,360,modulat,width)
	draw_arc(Vector2.ZERO,size * 2,-PI,PI,360,Color.white,width / 2)
	draw_arc(Vector2.ZERO,size / 1.3,-PI,PI,360,Color(1,1,1,0.3),width / 2)
	draw_circle(Vector2.ZERO,size / 2,modulat)
	draw_circle(Vector2.ZERO,width,modulat)
	draw_circle(Vector2.ZERO,width / 2,modulat)
	
	draw_arc(Vector2.ZERO,size / 2,-PI,PI,360,modulat.lightened(2),width / 2)
	
func _physics_process(delta: float) -> void:
	update()
	timer -= delta
	if timer < 0:
		queue_free()
	if timer < 0.3:
		modulate = modulate.linear_interpolate(Color.transparent,delta * 15)
	
	modulat = modulat.linear_interpolate(Color.transparent,delta * 15)
	size += (250 - size) * 0.1
	width += (1 - size) * 0.1
	
	
