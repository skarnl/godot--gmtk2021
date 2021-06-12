extends Node2D

func _ready():
	$RaksoAnimationPlayer.play('intro')
	
	yield($RaksoAnimationPlayer, 'animation_finished')
	
	Game.transition_to(Game.GameState.MAIN_MENU)


func _input(event):
	if event is InputEventKey and event.is_action_pressed('ui_accept'):
		if OS.is_debug_build():
			Game.transition_to(Game.GameState.GAME)
		else:	
			Game.transition_to(Game.GameState.MAIN_MENU)
