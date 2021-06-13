extends "res://entities/result/result.gd"

func set_updated_configuration( configuration: Configuration ) -> void:
	for part in PersonParts.keys():
		var sprite = self[part]
		
		if configuration[part] == -1:
			sprite.show()
		else:
			sprite.hide()


func reset() -> void:
	for part in PersonParts.keys():
		var sprite = self[part]
		sprite.show()
