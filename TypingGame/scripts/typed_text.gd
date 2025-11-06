class_name TypedText
extends HBoxContainer


var letter_prefab: PackedScene = preload('res://prefabs/letter.tscn')
var letters: Array[Letter] = []
var next_letter_index: int = 0
var is_complete: bool = false
var letter_typed: Callable
var completed: Callable


static func get_random_text(_size: int) -> String:
	var all_letters: String = 'abcdefghijklmnopqrstuvwxyz'
	var result: String = ''
	for i in _size:
		result += all_letters[randi() % len(all_letters)]
	return result


func set_letter_typed(_letter_typed: Callable):
	letter_typed = _letter_typed


func set_completed(_completed: Callable):
	completed = _completed


func set_text(_text: String) -> void:
	for child in get_children():
		child.queue_free()
	
	_text = _text.to_upper()
	for letter in _text:
		var letter_instance: Letter = letter_prefab.instantiate() as Letter
		letter_instance.set_letter(letter)
		letter_instance.set_as_next_letter(false)
		letters.append(letter_instance)
		add_child(letter_instance)
	
	letters[next_letter_index].set_as_next_letter(true)
	
	call_deferred('center_position')


func set_validated_color(_color: Color) -> void:
	for letter in letters:
		letter.set_validated_color(_color)


func on_letter_typed(_letter: String) -> void:
	if is_complete:
		return
	
	var next_letter: Letter = letters[next_letter_index]
	if next_letter.on_letter_typed(_letter):
		next_letter_index += 1
		if letter_typed:
			letter_typed.call()
	
	is_complete = next_letter_index == letters.size()
	if is_complete:
		completed.call()
	else:
		letters[next_letter_index].set_as_next_letter(true)


func center_position() -> void:
	position.x -= size.x * 0.5


func _enter_tree() -> void:
	TypingHandler.letter_typed.connect(on_letter_typed)


func _exit_tree() -> void:
	TypingHandler.letter_typed.disconnect(on_letter_typed)
