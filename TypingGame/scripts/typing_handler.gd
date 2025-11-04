extends Node


signal letter_typed(_letter: String)


func _input(_event: InputEvent) -> void:
	if _event is InputEventKey and _event.is_pressed() and not _event.is_echo():
		letter_typed.emit(OS.get_keycode_string(_event.keycode))
