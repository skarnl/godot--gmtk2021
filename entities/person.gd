extends Node2D


onready var head = $Head
onready var hair = $Hair
onready var ears = $Ears
onready var eyes = $Eyes
onready var nose = $Nose
onready var mouth = $Mouth


var rng: RandomNumberGenerator = RandomNumberGenerator.new()


func _ready() -> void:
	rng.randomize()
	
#	head - don't set it now, since we only have a circled variant
	
	_set_random_frame(hair)
	_set_random_frame(ears)
	_set_random_frame(eyes)
	_set_random_frame(nose)
	_set_random_frame(mouth)


	# debug
	print(get_configuration())


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
