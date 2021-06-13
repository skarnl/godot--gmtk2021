extends Object
class_name Configuration

const VARIANTS = 4


var head: int = 0
var hair: int = -1
var eyes: int = -1
var mouth: int = -1
var ears: int = -1
var nose: int = -1


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

func get_hash() -> int:
	return _to_dictionary().hash()
