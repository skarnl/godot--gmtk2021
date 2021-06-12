## Suspects Controller
##
## Keeps track of the number of variants
## Make sure the 'market' is filled with enough persons etc
extends Node2D


enum DIFFICULTY { EASY = 3, MEDIUM = 4, HARD = 5} # 5 is de max nu, totdat we meer variaties hebben qua onderdelen ^^


const PersonScene = preload('res://entities/person/person.tscn')


export (DIFFICULTY) var difficulty = DIFFICULTY.EASY
export (int) var suspects = 9


var cols = 3
var cell_size = 200


func set_target_configuration(target_config: Configuration) -> void:
	print("target = ", target_config)
	
	_clear_market()
	_create_variants(target_config)
	_fill_market()
	_shuffle_market_positions()


func _clear_market() -> void:
	for c in get_children():
		c.queue_free()



func _create_variants(target_config: Configuration) -> void:
	for i in difficulty:
		var p = PersonScene.instance()
		add_child(p)
		p.set_configuration( _get_configuration(i, target_config) )
		


func _get_configuration( index: int, target_config: Configuration) -> Configuration:
	match difficulty:
		DIFFICULTY.EASY:
			match index:
				0:
					return _create_forced_configuration(target_config, [PersonParts.NOSE, PersonParts.HAIR])
				1:
					return _create_forced_configuration(target_config, [PersonParts.MOUTH])
				2:
					return _create_forced_configuration(target_config, [PersonParts.EYES, PersonParts.EARS])
		
		DIFFICULTY.MEDIUM:
			match index:
				0:
					return _create_forced_configuration(target_config, [PersonParts.NOSE, PersonParts.MOUTH])
					
				1:
					return _create_forced_configuration(target_config, [PersonParts.MOUTH, PersonParts.EARS])
					
				2:
					return _create_forced_configuration(target_config, [PersonParts.EYES, PersonParts.EARS, PersonParts.HAIR])
										
				3:
					return _create_forced_configuration(target_config, [PersonParts.EYES, PersonParts.NOSE, PersonParts.HAIR])
					
			
		DIFFICULTY.HARD:
			match index:
				0:
					return _create_forced_configuration(target_config, [PersonParts.NOSE, PersonParts.EARS, PersonParts.MOUTH])
					
				1:
					return _create_forced_configuration(target_config, [PersonParts.EARS, PersonParts.MOUTH, PersonParts.HAIR])
					
				2:
					return _create_forced_configuration(target_config, [PersonParts.EYES, PersonParts.MOUTH, PersonParts.HAIR])
					
				3:
					return _create_forced_configuration(target_config, [PersonParts.EYES, PersonParts.NOSE, PersonParts.HAIR])
					
				4:
					return _create_forced_configuration(target_config, [PersonParts.EYES, PersonParts.NOSE, PersonParts.EARS])
		
	return Configuration.new()
	

func _create_forced_configuration(base_configuration: Configuration, parts_to_overwrite = []) -> Configuration:
	var c = Helpers.clone(base_configuration)
	
	for part in c.keys():
		if parts_to_overwrite.has(part):
			c[part] = Helpers.get_random_frame([c[part]])
		
	return c


func _fill_market():
	var extras_needed = suspects - difficulty
	
	for i in extras_needed:
		var p = PersonScene.instance()
		add_child(p)
	
	
func _shuffle_market_positions():
	var index = 0
	var row = 0
	
	var shuffled_children = get_children().duplicate()
	shuffled_children.shuffle()
	
	for c in shuffled_children:
		c.position = Vector2(index % cols * cell_size, row * cell_size)
		
		if index % cols == 2:
			row += 1
			
		index += 1
