extends Node2D


var target_config


onready var target = $Target
onready var result = $Result
onready var market = $Market


func _ready():
	result.hide()
	
#	get target configuration
	target_config = target.get_configuration()

	market.set_target_configuration(target_config)
	
	market.connect('selection_updated', self, '_on_Market_selection_updated')

#   bereken elke keer het eindresultaat
#   toon het eindresultaat direct

#    -> dit wordt later pas gedaan ON CLICK van de process-knop


func _on_Market_selection_updated(configurations: Array) -> void:
	if configurations.size() == 0:
		result.hide()
	else:
		result.show()
		
		var combined_configuration := _calculate_combined_configuration(configurations)
		
		result.set_configuration( combined_configuration )
		
		# TEMP DEBUG
		result.mark_as_success = combined_configuration.get_hash() == target_config.get_hash()

func _calculate_combined_configuration(configurations: Array) -> Configuration:
	var merged_configuration = Configuration.new()
	
	# prepare counted object
	for part in PersonParts.keys():
		var temp_collection := {}
		var highest_count := 0
		var value_of_highest_count := -1
		
		# get all the values for the current part
		for config in configurations:
			var value = config[part]
			
			if temp_collection.has(value):
				temp_collection[value] += 1
			else:
				temp_collection[value] = 1
			
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
