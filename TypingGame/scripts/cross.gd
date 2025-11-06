class_name Cross
extends Node2D


@onready var typed_text: TypedText = $TypedText


func on_completed() -> void:
	for enemy in Game.instance.enemies:
		enemy.typed_text.type_next_letter()
	
	queue_free()


func _ready() -> void:
	typed_text.set_text('cross')
	typed_text.set_completed(on_completed)
