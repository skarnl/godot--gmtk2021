tool
extends Control

export(String, MULTILINE) var text := "Dialog box text" setget _set_text

func _ready() -> void:
	_set_text(text)

func _set_text(text_value) -> void:
	text = text_value
	$Border/MarginContainer/Label.text = text

