extends AudioStreamPlayer

func start() -> void:
	if not is_playing():
		play()
