shader_type canvas_item;

void vertex(){
	VERTEX.x += sin(VERTEX.y + TIME * 0.2 + VERTEX.x) * 4.2;
	VERTEX.y += sin(VERTEX.x + TIME * 1.5 + VERTEX.y) * 2.2;
}