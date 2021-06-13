extends Control

signal start_game

# Called when the node enters the scene tree for the first time.
func _ready():
	$StartButton.grab_focus()
	show()
	
	BackgroundMusic.start()
	$AnimationPlayer.play('type')


func _on_StartButton_pressed() -> void:
	Game.start_game()
	
	hide()

