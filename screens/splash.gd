extends Node2D

func _ready():
	$RaksoAnimationPlayer.play('intro')
	
	yield($RaksoAnimationPlayer, 'animation_finished')
	
	Game.transition_to(Game.GameState.MAIN_MENU)


func _input(event):
	if event is InputEventKey and event.is_pressed() or event is InputEventMouseButton :
		Game.transition_to(Game.GameState.MAIN_MENU)
