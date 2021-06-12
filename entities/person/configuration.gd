class_name Configuration
extends Object

const VARIANTS = 4

var head: int = 0
var hair: int
var eyes: int
var mouth: int
var ears: int
var nose: int

func _init(initial_config: Dictionary = {}) -> void:
	for k in initial_config.keys():
		if k in self:
			self[k] = initial_config.get(k)


func _to_string() -> String:
	var d = {}
	
	d.head = head
	d.hair = hair
	d.eyes = eyes
	d.mouth = mouth
	d.ears = ears
	d.nose = nose
	
	return JSON.print(d)
