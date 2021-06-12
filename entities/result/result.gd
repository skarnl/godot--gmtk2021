extends "res://entities/person/person.gd"

var mark_as_success := false setget _set_mark_as_success

func _draw() -> void:
	if mark_as_success:
		draw_rect(Rect2(Vector2(10.0, 10.0), Vector2(190.00, 190.00)), Color.green.lightened(0.2))


func _set_mark_as_success(new_value):
	mark_as_success = new_value
	
	update()
