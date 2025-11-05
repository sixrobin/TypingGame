class_name Heal
extends Node2D


@onready var typed_text: TypedText = $TypedText


func on_completed() -> void:
	Game.instance.player.heal(5)
	queue_free()


func _ready() -> void:
	typed_text.set_text('heal')
	typed_text.set_completed(on_completed)
