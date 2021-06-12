extends "res://entities/market/market.gd"

export(Array) var market_persons = []

func _ready() -> void:
	market_size = market_persons.size()


func set_market_configuration(configurations: Array) -> void:
	_clear_market()
	
	for config in configurations:
		var p = MarketPersonScene.instance()
		add_child(p)
		p.set_configuration(config)
	
	_position_in_grid(get_children())
	_add_listeners()
