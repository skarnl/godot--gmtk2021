extends Node2D


onready var head = $Head
onready var hair = $Hair
onready var ears = $Ears
onready var eyes = $Eyes
onready var nose = $Nose
onready var mouth = $Mouth


var rng: RandomNumberGenerator = RandomNumberGenerator.new()


var PARTS = ['hair', 'ears', 'eyes', 'nose', 'mouth']


func _ready() -> void:
	rng.randomize()
	
#	head - don't set it now, since we only have a circled variant
	
#	this will make all the parts random
	set_configuration({})

	# debug
	print(get_configuration())


func set_configuration(config: Dictionary, exclude: Dictionary = {}) -> void:
	for part in ['hair', 'ears', 'eyes', 'nose', 'mouth']:
		var sprite = self[part]
		
		if (config.has(part)):
			sprite.set_frame_coords(Vector2( config[part], sprite.get_frame_coords().y))
		elif (exclude.has(part)):
			pass
		else:
			_set_random_frame(sprite)
			

func _get_random_frame(sprite: Sprite) -> float:
	return rng.randf_range(0, sprite.hframes)


func _set_random_frame(sprite: Sprite) -> void:
	sprite.set_frame_coords(Vector2(_get_random_frame(sprite), sprite.get_frame_coords().y))


func get_configuration() -> Dictionary:
	print("configuration: ")
	
	var config = {}
	
	for sprite in ['hair', 'ears', 'eyes', 'nose', 'mouth']:
		config[sprite] = self[sprite].get_frame_coords().x

	return config
