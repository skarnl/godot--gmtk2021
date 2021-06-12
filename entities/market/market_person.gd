extends Area2D


signal selected
signal deselected


onready var person := $Person


var _selected := false
var mark_as_variant := false


func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if (event is InputEventMouseButton and event.pressed):
		_selected = !_selected
		
		if _selected:
			emit_signal('selected')
		else:
			emit_signal('deselected')

		_update_selected_render()


func _update_selected_render() -> void:
#	TODO render hier iets om aan te geven dat het geselecteerd is of niet
	update()
	pass


func _draw() -> void:
	if OS.is_debug_build() and mark_as_variant:
		draw_rect(Rect2(Vector2(10.0, 10.0), Vector2(190.00, 190.00)), Color.crimson.lightened(0.4))
		
	if _selected:
		draw_rect(Rect2(Vector2(10.0, 10.0), Vector2(190.00, 190.00)), Color.yellow.lightened(0.6))
		

func set_configuration(config:Configuration) -> void:
	person.set_configuration(config)



func get_configuration() -> Configuration:
	return person.get_configuration()


func is_selected() -> bool:
	return _selected
