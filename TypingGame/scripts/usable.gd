class_name Usable
extends Node2D


@onready var typed_text: TypedText = $TypedText


func on_text_completed() -> void:
	queue_free()


func _enter_tree() -> void:
	Game.instance.add_usable(self)


func _exit_tree() -> void:
	Game.instance.remove_usable(self)


func _ready() -> void:
	typed_text.set_completed(on_text_completed)
