extends "res://game/game.gd"

var first_configuration: Configuration = Configuration.new({
			PersonParts.HEAD: 0,
			PersonParts.HAIR: 3,
			PersonParts.EARS: 0,
			PersonParts.EYES: 0,
			PersonParts.NOSE: 0,
			PersonParts.MOUTH: 0
		})
		
var second_configuration: Configuration = Configuration.new({
			PersonParts.HEAD: 0,
			PersonParts.HAIR: 0,
			PersonParts.EARS: 0,
			PersonParts.EYES: 1,
			PersonParts.NOSE: 0,
			PersonParts.MOUTH: 1
		})
		
var third_configuration: Configuration = Configuration.new({
			PersonParts.HEAD: 0,
			PersonParts.HAIR: 0,
			PersonParts.EARS: 0,
			PersonParts.EYES: 0,
			PersonParts.NOSE: 1,
			PersonParts.MOUTH: 0
		})

func _on_ready():
	result.hide()
	
	# head, hair, eyes, ears, nose, mouth
	target_config = Configuration.new({
		PersonParts.HEAD: 0,
		PersonParts.HAIR: 0,
		PersonParts.EARS: 0,
		PersonParts.EYES: 0,
		PersonParts.NOSE: 0,
		PersonParts.MOUTH: 0
	})
	target.set_configuration(target_config)
	result_preview.set_configuration(target_config)

	$ForcedMarket.set_market_configuration([first_configuration, second_configuration, third_configuration])
	$ForcedMarket.connect('selection_updated', self, '_on_ForcedMarket_selection_updated')



func _on_ForcedMarket_selection_updated(configurations: Array) -> void:
	print('Tutorial::_on_Market_selection_updated')
	
	if (configurations.has(first_configuration)):
		print('eerste config aangeklikt')
		
	if (configurations.has(second_configuration)):
		print('tweede config aangeklikt')
		
	if (configurations.has(third_configuration)):
		print('derde config aangeklikt')
	# toon de mogelijkheden en dat er dus niks gegetoond kan worden als het 'gelijk' is qua score
	
	_on_Market_selection_updated(configurations)


func _on_NextLevelButton_pressed() -> void:
	Game.goto_next_level()
