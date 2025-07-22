extends Control

var selected_class = -1
onready var class_buttons = [$class_sword, $class_gun, $class_magic, $class_angel, $class_smartphone]

var class_titles = [
	"Sword",
	"Gunslinger",
	"Magician",
	"Angel",
	"Smartphone",
]
var class_descs = [
	"You will use the sword who specializes in close ranged attacks and powerful timed swings",
	"You have anything to do to enemies at a distance. Your trusty trigger finger always listens to you",
	"The way of the runics is at your command. You will make explosions from a wave of hand gestures.",
	"At the field of battle sometimes its nice to have a way to channel the light from the exemplar and make a wish to stave off wounds. You will always have ample opportunity to Heal during battle.",
	"Smartphone???. Our scholars havent the slightest idea of the impetus of this object.",
]




func _physics_process(delta: float) -> void:


	
	$description.position /= 1.2
	for i in range(class_buttons.size()):
		class_buttons[i].rect_position = class_buttons[i].rect_position.linear_interpolate($Position2D.position + Vector2(i * 28,0),delta * 15)
		if class_buttons[i].hovered:
			$description/title.text = class_titles[i]
			$description/desc.text = class_descs[i]
		if class_buttons[i].clicked():
			selected_class = i
			$description.position.x += 40
			
	if selected_class != -1:
		class_buttons[selected_class].rect_position.y += -1
		$selected_class_effect.rect_position = $selected_class_effect.rect_position.linear_interpolate(class_buttons[selected_class].rect_position,delta * 25)
		class_buttons[selected_class].get_node("ColorRect").modulate = Color.white
		
		$description/title.text = class_titles[selected_class]
		$description/desc.text = class_descs[selected_class]
		
		
		
