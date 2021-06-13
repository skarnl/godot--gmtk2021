extends "res://entities/person/person.gd"

var _target_configuration:Configuration

func set_configuration( target_configuration: Configuration ) -> void:
	_target_configuration = target_configuration
	
	.set_configuration(target_configuration)


func set_updated_configuration( configuration: Configuration ) -> void:
	for part in PersonParts.keys():
		var sprite = self[part]
		
		if does_part_matches_target_part(configuration, part):
			sprite.show()
		else:
			sprite.hide()


func does_part_matches_target_part(configuration: Configuration, part: String) -> bool:
	return configuration[part] == _target_configuration[part]
