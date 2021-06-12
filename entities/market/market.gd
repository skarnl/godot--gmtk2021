## market_size Controller
##
## Keeps track of the number of variants
## Make sure the 'market' is filled with enough persons etc
extends Node2D


signal selection_updated(configurations)


enum DIFFICULTY { EASY = 3, MEDIUM = 4, HARD = 5} # 5 is de max nu, totdat we meer variaties hebben qua onderdelen ^^


const MarketPersonScene = preload('res://entities/market/market_person.tscn')


export (DIFFICULTY) var difficulty = DIFFICULTY.EASY
export (int) var market_size = 9


var cols = 3
var cell_size = 200


func set_target_configuration(target_config: Configuration) -> void:
	print("target = ", target_config)
	
	_clear_market()
	_create_variants(target_config)
	_fill_market()
	_shuffle_market_positions()
	_add_listeners()


func _clear_market() -> void:
	for c in get_children():
		c.queue_free()



func _create_variants(target_config: Configuration) -> void:
	var adjusted_values = {}
	
	for part in PersonParts.keys():
		adjusted_values[part] = []
	
	for i in difficulty:
		var p = MarketPersonScene.instance()
		p.mark_as_variant = true
		add_child(p)
		
		var config_set = _get_configuration(i, target_config, adjusted_values)
		
		p.set_configuration( config_set.config )
		
		# update the adjusted values, so we can keep track of what random part values we used
		for part in PersonParts.keys():
			if part in config_set.adjusted_values:
				adjusted_values[part].append(config_set.adjusted_values[part])
		

func _get_configuration( index: int, target_config: Configuration, adjusted_values: Dictionary) -> Dictionary:
	match difficulty:
		DIFFICULTY.EASY:
			match index:
				0:
					return _create_forced_configuration(target_config, [PersonParts.NOSE, PersonParts.HAIR], adjusted_values)
				1:
					return _create_forced_configuration(target_config, [PersonParts.MOUTH], adjusted_values)
				2:
					return _create_forced_configuration(target_config, [PersonParts.EYES, PersonParts.EARS], adjusted_values)
		
		DIFFICULTY.MEDIUM:
			match index:
				0:
					return _create_forced_configuration(target_config, [PersonParts.NOSE, PersonParts.MOUTH], adjusted_values)
					
				1:
					return _create_forced_configuration(target_config, [PersonParts.MOUTH, PersonParts.EARS], adjusted_values)
					
				2:
					return _create_forced_configuration(target_config, [PersonParts.EYES, PersonParts.EARS, PersonParts.HAIR], adjusted_values)
										
				3:
					return _create_forced_configuration(target_config, [PersonParts.EYES, PersonParts.NOSE, PersonParts.HAIR], adjusted_values)
					
			
		DIFFICULTY.HARD:
			match index:
				0:
					return _create_forced_configuration(target_config, [PersonParts.NOSE, PersonParts.EARS, PersonParts.MOUTH], adjusted_values)
					
				1:
					return _create_forced_configuration(target_config, [PersonParts.EARS, PersonParts.MOUTH, PersonParts.HAIR], adjusted_values)
					
				2:
					return _create_forced_configuration(target_config, [PersonParts.EYES, PersonParts.MOUTH, PersonParts.HAIR], adjusted_values)
					
				3:
					return _create_forced_configuration(target_config, [PersonParts.EYES, PersonParts.NOSE, PersonParts.HAIR], adjusted_values)
					
				4:
					return _create_forced_configuration(target_config, [PersonParts.EYES, PersonParts.NOSE, PersonParts.EARS], adjusted_values)
		
	return {
		config = Configuration.new(),
		adjusted_values = {}
	}
	

func _create_forced_configuration(base_configuration: Configuration, parts_to_overwrite: Array, adjusted_values: Dictionary) -> Dictionary:
	var c = Helpers.clone(base_configuration)
	var _adjusted_values = {}
	
	for part in PersonParts.keys():
		if parts_to_overwrite.has(part):
			var excluded_values = [c[part]].duplicate()
			excluded_values.append_array(adjusted_values[part])
			
			c[part] = Helpers.get_random_frame(excluded_values)
			_adjusted_values[part] = c[part]
		
	return {
		config = c,
		adjusted_values = _adjusted_values,
	}


func _fill_market() -> void:
	var extras_needed = market_size - difficulty
	
	for i in extras_needed:
		var p = MarketPersonScene.instance()
		add_child(p)
	
	
func _shuffle_market_positions() -> void:
	var index = 0
	
	var shuffled_children = get_children().duplicate()
	shuffled_children.shuffle()
	
	for c in shuffled_children:
		c.position = Vector2(index % cols * cell_size, index / cols * cell_size)
		
		index += 1


func _add_listeners() -> void:
	for c in get_children():
		c.connect('selected', self, '_on_MarketPerson_selection_changed')
		c.connect('deselected', self, '_on_MarketPerson_selection_changed')


func _on_MarketPerson_selection_changed() -> void:
	var selected_configurations = []
	
	for c in get_children():
		if c.is_selected():
			selected_configurations.append(c.get_configuration())

	emit_signal('selection_updated', selected_configurations)
