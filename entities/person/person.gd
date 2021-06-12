extends Node2D


onready var head = $Head
onready var hair = $Hair
onready var ears = $Ears
onready var eyes = $Eyes
onready var nose = $Nose
onready var mouth = $Mouth


var mark_as_variant = false


var rng: RandomNumberGenerator = RandomNumberGenerator.new()


var PARTS = [PersonParts.EARS, PersonParts.EYES, PersonParts.NOSE, PersonParts.MOUTH, PersonParts.HAIR]


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
	for part in PARTS:
		var sprite = self[part]
		
		if (part in config):
			sprite.set_frame_coords(Vector2( config[part], sprite.get_frame_coords().y))



func get_configuration() -> Configuration:
	var config = {}
	
	for part in PARTS:
		config[part] = self[part].get_frame_coords().x

	return Configuration.new(config)


func _draw() -> void:
	if OS.is_debug_build() and mark_as_variant:
		draw_rect(Rect2(Vector2(10.0, 10.0), Vector2(190.00, 190.00)), Color.crimson.lightened(0.4))
