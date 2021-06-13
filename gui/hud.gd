extends CanvasLayer


func _ready() -> void:
	if Level.level == 0:
		$HUD/LevelLabel.text = "Level : tutorial"
	else:
		$HUD/LevelLabel.text = "Level : %d" % Level.level


func update_tries(tries: int) -> void:
	$HUD/TriesLabel.text = "Tries : %d" % tries
