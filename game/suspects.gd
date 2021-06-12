extends Node2D


var PersonScene = preload('res://entities/person/person.tscn')


# A node to control the suspects
# Keep track of the number of variants
# Make sure the 'market' is filled with enough persons etc

enum DIFFICULTY { EASY = 3, MEDIUM = 4, HARD = 5} # 5 is de max nu, totdat we meer variaties hebben qua onderdelen ^^

export (DIFFICULTY) var difficulty = DIFFICULTY.EASY
export (int) var suspects = 9

var rows = 3
var cols = 3
var cell_size = 200


func set_target_configuration(config: Dictionary) -> void:
	_create_variants()


func _create_variants():
	for c in get_children():
		c.queue_free()
	
	for i in difficulty:
		var p = PersonScene.instance()
		add_child(p)
		p.position = Vector2(i * cell_size, 0.0)
		
		
func _fill_market():
	pass
	
	
func _shuffle_market_positions():
	pass
