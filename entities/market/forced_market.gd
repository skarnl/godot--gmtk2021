extends "res://entities/market/market.gd"

func set_market_configuration(configurations: Array) -> void:
	_clear_market()
	
	for config in configurations:
		var p = MarketPersonScene.instance()
		add_child(p)
		p.set_configuration(config)
	
	_position_in_grid(get_children())
	_add_listeners()


func _calculate_market_size() -> int:
	return get_child_count()
