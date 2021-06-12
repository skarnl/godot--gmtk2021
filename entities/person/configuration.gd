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
	return JSON.print(_to_dictionary())


func _to_dictionary() -> Dictionary:
	var d = {}
	
	for k in PersonParts.keys():
		d[k] = self[k]
	
	return d
