class_name Letter
extends Control


@onready var animator: Control = $LetterAnimator

var letter: String = ''
var validated_color: Color = Color.GREEN


func set_letter(_letter: String) -> void:
	letter = _letter
	($LetterAnimator/Letter as RichTextLabel).text = letter


func set_as_next_letter(_is_next_letter: bool) -> void:
	modulate = Color.WHITE if _is_next_letter else Color.GRAY


func set_validated_color(_color: Color) -> void:
	validated_color = _color


func on_letter_typed(_letter: String) -> bool:
	if letter != _letter:
		return false;
	
	on_letter_validated()
	return true


func on_letter_validated() -> void:
	modulate = validated_color
	
	animator.pivot_offset = animator.size * 0.5
	animator.scale = Vector2.ONE * 1.7
	var scale_tween = create_tween()
	scale_tween.tween_property(animator, 'scale', Vector2.ONE, 0.5).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_ELASTIC)
