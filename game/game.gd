extends Node2D


var target_config


onready var target := $Target
onready var result := $Result
onready var result_preview := $ResultPreview
onready var market := $Market
onready var next_level_button := $NextLevelButton
onready var summary := $Summary

func _ready():
	_on_ready()
	
	
func _on_ready():
	result.hide()
	next_level_button.hide()
	
#	get target configuration
	target_config = target.get_configuration()
	
	result_preview.set_configuration(target_config)

	market.set_target_configuration(target_config)
	market.connect('selection_updated', self, '_on_Market_selection_updated')

#   bereken elke keer het eindresultaat
#   toon het eindresultaat direct

#    -> dit wordt later pas gedaan ON CLICK van de process-knop


func _on_Market_selection_updated(configurations: Array) -> void:
	if configurations.size() == 0:
		result.hide()
		summary.update_summary(Configuration.new(), target_config)
		result_preview.reset()
	else:
		result.show()
		
		var combined_configuration := _calculate_combined_configuration(configurations)
		
		result.set_configuration( combined_configuration )
		result_preview.set_updated_configuration( combined_configuration )
		
		# TEMP DEBUG
		result.mark_as_success = combined_configuration.get_hash() == target_config.get_hash()
		
		if result.mark_as_success:
			next_level_button.show()
		else:
			next_level_button.hide()
			
		summary.update_summary(combined_configuration, target_config)

func _calculate_combined_configuration(configurations: Array) -> Configuration:
	var merged_configuration = Configuration.new()
	
	# prepare counted object
	for part in PersonParts.keys():
		
		var highest_count := 0
		var value_of_highest_count := -1
		
		# get all the values for the current part
		var temp_collection = _get_counts_per_part(part, configurations)
			
		# get the highest counted value
		var values = temp_collection.keys();
		for value in values: 
			var count = temp_collection[value]
			
			# if we have a value with more counts
			if count > highest_count:
				highest_count = count
				value_of_highest_count = value
				
			elif count == highest_count:
				# reset the highest value, since there are more with the same count
				value_of_highest_count = -1
	
		merged_configuration[part] = value_of_highest_count
		
	return merged_configuration


func _get_counts_per_part(part: String, configurations: Array) -> Dictionary:
	var temp_collection := {}
	
	for config in configurations:
		var value = config[part]
		
		if temp_collection.has(value):
			temp_collection[value] += 1
		else:
			temp_collection[value] = 1
	
	return temp_collection


func _on_NextLevelButton_pressed() -> void:
	# increase level-counter
	# so we can increase difficulty / market-size etc
	
	Game._restart()
