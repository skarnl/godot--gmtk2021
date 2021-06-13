extends Node2D

func _ready() -> void:
	for c in get_children():
		c.hide()
	

func select() -> void:
	var shuffled = get_children().duplicate()
	shuffled.shuffle()
	
	var first = shuffled.pop_front()
	first.show()

func deselect() -> void:
	for c in get_children():
		c.hide()
