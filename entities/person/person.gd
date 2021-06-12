extends Node2D


onready var head = $Head
onready var hair = $Hair
onready var ears = $Ears
onready var eyes = $Eyes
onready var nose = $Nose
onready var mouth = $Mouth


var rng: RandomNumberGenerator = RandomNumberGenerator.new()

var VARIANTS = 4
var PARTS = ['ears', 'eyes', 'nose', 'mouth', 'hair']


func _ready() -> void:
	rng.randomize()
	
#	head - don't set it now, since we only have a circled variant
	_correct_frame_numbers()
	
#	this will make all the parts random, since we pass in an empty configuration
	set_configuration(Configuration.new())


# fix the hframes, so we don't have to adjust them in the editor when adding new variants
func _correct_frame_numbers() -> void:
	var vframe = 1.0
	for part in PARTS:
		self[part].set_vframes(6)
		self[part].set_hframes(VARIANTS)
		self[part].set_frame_coords(Vector2(0, vframe))
		
		vframe += 1.0
		

func set_configuration(config: Configuration, exclude: Dictionary = {}) -> void:
	for part in PARTS:
		var sprite = self[part]
		
		if (config[part] != 0):
			sprite.set_frame_coords(Vector2( config[part], sprite.get_frame_coords().y))
		elif (exclude.has(part)):
			pass
		else:
			_set_random_frame(sprite)
			

func _get_random_frame(sprite: Sprite) -> float:
	return rng.randf_range(0, sprite.hframes)


func _set_random_frame(sprite: Sprite) -> void:
	sprite.set_frame_coords(Vector2(_get_random_frame(sprite), sprite.get_frame_coords().y))


func get_configuration() -> Configuration:
	var config = {}
	
	for part in PARTS:
		config[part] = self[part].get_frame_coords().x

	return Configuration.new(config)
