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


var finished := false


func _initialize() -> void:
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
	result.set_configuration( target_config )
	result_preview.set_configuration(target_config)

	$ForcedMarket.set_market_configuration([first_configuration, second_configuration, third_configuration])
	$ForcedMarket.connect('selection_updated', self, '_on_ForcedMarket_selection_updated')

	$TutorialGuide.connect('finished', self, '_on_TutorialGuide_finished')
	
	

func _on_ForcedMarket_selection_updated(configurations: Array) -> void:
	_on_Market_selection_updated(configurations)
	
	if finished:
		return
		
	 # not until the tutorial tells us to ^^
	next_level_button.hide()
	
	var combined_configuration := _calculate_combined_configuration(configurations)
	
	if combined_configuration.get_hash() == target_config.get_hash():
		$TutorialGuide.matched()
	else:
		$TutorialGuide.selected(combined_configuration, configurations.size())
	

func _on_TutorialGuide_finished() -> void:
	finished = true
	next_level_button.show()


func _on_NextLevelButton_pressed() -> void:
	Level.increase()
	Game.goto_next_level()
