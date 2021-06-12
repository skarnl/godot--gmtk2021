extends Node2D


const VARIANTS = 4


var rng: RandomNumberGenerator = RandomNumberGenerator.new()


func _init() -> void:
	rng.randomize()


## Get random frame
## (optional) excludes {array} with numbers to ignore
func get_random_frame(excludes = []) -> int:
	var result = rng.randi_range(0, VARIANTS - 1)
	
	assert(excludes.size() < VARIANTS)
	
	while excludes.has(result):
		result = rng.randi_range(0, VARIANTS - 1)
		
	return result


func clone(config: Configuration) -> Configuration:
	return Configuration.new(config._to_dictionary())
