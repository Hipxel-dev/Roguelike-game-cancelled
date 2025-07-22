extends Control

onready var trinkets = []
onready var trinket_btn = $trinket_btn.duplicate()

var hovered_index = -1

func _ready() -> void:
	$trinket_btn.queue_free()
	gamesystem.trinket_hud = self

func insert_trinket_icon(trnkt_data = null):
	var trinket_btn_inst = trinket_btn.duplicate()
	trinket_btn_inst.get_node("icon").texture = trnkt_data.trinket_icon
	trinkets.append(trinket_btn_inst)
	add_child(trinket_btn_inst)
	
func _physics_process(delta: float) -> void:
	hovered_index = -1
	for i in range(trinkets.size()):
		trinkets[i].rect_position = trinkets[i].rect_position.linear_interpolate($anchor.position + Vector2(0,i * 24),delta * 15)
		if trinkets[i].get_node("ms").hovered:
			hovered_index = i
			
	if hovered_index != -1:
		$desc.scale = $desc.scale.linear_interpolate(Vector2.ONE,delta * 15)
		$desc.position = trinkets[hovered_index].rect_position
		
		var trink_data =  gamesystem.player.get_node("trinkets").get_children()[hovered_index]
		$desc.get_node("ColorRect/text").text = trink_data.trinket_name
		$desc.get_node("ColorRect/text2").text = trink_data.trinket_desc
	else:
		$desc.scale /= 1.3
		
