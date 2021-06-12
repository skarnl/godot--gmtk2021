extends Node2D


onready var head = $Head
onready var hair = $Hair
onready var ears = $Ears
onready var eyes = $Eyes
onready var nose = $Nose
onready var mouth = $Mouth


var rng: RandomNumberGenerator = RandomNumberGenerator.new()
const PARTS = [PersonParts.EARS, PersonParts.EYES, PersonParts.NOSE, PersonParts.MOUTH, PersonParts.HAIR]

var _configuration:Configuration

func _ready() -> void:
	rng.randomize()
	
#	head - don't set it now, since we only have a circled variant
	_correct_frame_numbers()
	
	_create_random_configuration()
	
#	
func _create_random_configuration():
	var c = Configuration.new()
	
	for part in PARTS:
		c[part] = Helpers.get_random_frame()
		
	set_configuration(c)


# fix the hframes, so we don't have to adjust them in the editor when adding new variants
func _correct_frame_numbers() -> void:
	var vframe = 1.0
	for part in PARTS:
		self[part].set_vframes(6)
		self[part].set_hframes(Helpers.VARIANTS)
		self[part].set_frame_coords(Vector2(0, vframe))
		
		vframe += 1.0
		

func set_configuration(config: Configuration, exclude: Dictionary = {}) -> void:
	_configuration = config
	
	for part in PARTS:
		var sprite = self[part]
		
		if (part in _configuration):
			sprite.set_frame_coords(Vector2( _configuration[part], sprite.get_frame_coords().y))



func get_configuration() -> Configuration:
	return _configuration

