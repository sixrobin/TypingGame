class_name Player
extends Node2D


@export var health: int = 100

@onready var health_bar: ProgressBar = $ProgressBar

var cast_letter_prefab: PackedScene = preload("res://prefabs/cast_letter.tscn")


func take_damage(_damage: int) -> void:
	health = max(health - _damage, 0)
	health_bar.value = health
	
	if health == 0:
		print('Player is dead')


func on_letter_typed(_letter: String) -> void:
	var cast_letter_instance: RichTextLabel = cast_letter_prefab.instantiate() as RichTextLabel
	cast_letter_instance.text = _letter
	cast_letter_instance.scale = Vector2.ZERO
	cast_letter_instance.pivot_offset = cast_letter_instance.size * 0.5
	add_child(cast_letter_instance)
	cast_letter_instance.position = -cast_letter_instance.size * 0.5 + Vector2.UP * 120
	
	var tween: Tween = create_tween()
	tween.tween_property(cast_letter_instance, 'scale', Vector2.ONE, 0.3).set_trans(Tween.TRANS_ELASTIC).set_ease(Tween.EASE_OUT)
	tween.tween_interval(0.05)
	tween.tween_callback(cast_letter_instance.queue_free)


func _enter_tree() -> void:
	TypingHandler.letter_typed.connect(on_letter_typed)


func _exit_tree() -> void:
	TypingHandler.letter_typed.disconnect(on_letter_typed)


func _ready() -> void:
	health_bar.min_value = 0
	health_bar.max_value = health
	health_bar.value = health
