extends Node2D

onready var hair_missing := $HairMissing
onready var hair_matching := $HairMatching
onready var eyes_missing := $EyesMissing
onready var eyes_matching := $EyesMatching
onready var nose_missing := $NoseMissing
onready var nose_matching := $NoseMatching
onready var mouth_missing := $MouthMissing
onready var mouth_matching := $MouthMatching
onready var ears_missing := $EarsMissing
onready var ears_matching := $EarsMatching

func _ready() -> void:
	for part in PersonParts.keys():
		show_part_missing(part)


func update_summary(configuration: Configuration, target_configuration: Configuration) -> void:
	for part in PersonParts.keys():
		if configuration[part] == target_configuration[part]:
			show_part_matching(part)
		else:
			show_part_missing(part)
			

func show_part_missing(part: String) -> void:
	self[part + '_missing'].show()
	self[part + '_matching'].hide()
	
func show_part_matching(part: String) -> void:
	self[part + '_matching'].show()
	self[part + '_missing'].hide()
