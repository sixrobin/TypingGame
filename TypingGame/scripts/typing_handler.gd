extends Node


signal letter_typed(_letter: String)


func _input(_event: InputEvent) -> void:
	if not _event is InputEventKey:
		return
	if not _event.is_pressed():
		return
	if _event.is_echo():
		return
		
	var input_string: String = OS.get_keycode_string(_event.keycode)
	
	var letter_regex = RegEx.new()
	letter_regex.compile("[a-zA-Z]")
	var matches: Array[RegExMatch] = letter_regex.search_all(input_string)
	if matches.size() != 1:
		return
	
	letter_typed.emit(input_string)
