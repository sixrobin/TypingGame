class_name CastFeedback
extends Node2D


func on_enemy_added(_enemy: Enemy) -> void:
	_enemy.ready.connect(func(): on_enemy_ready(_enemy))


func on_enemy_ready(_enemy: Enemy) -> void:
	_enemy.typed_text.letter_typed.connect(func(): on_enemy_letter_typed(_enemy))


func on_usable_added(_usable: Usable) -> void:
	_usable.ready.connect(func(): on_usable_ready(_usable))


func on_usable_ready(_usable: Usable) -> void:
	_usable.typed_text.letter_typed.connect(func(): on_usable_letter_typed(_usable))


func on_enemy_letter_typed(_enemy: Enemy) -> void:
	create_line(
		Game.instance.player.global_position + Vector2.UP * 100,
		_enemy.global_position + Vector2.UP * 100,
		Color.CORNFLOWER_BLUE)


func on_usable_letter_typed(_usable: Usable) -> void:
	create_line(
		Game.instance.player.global_position + Vector2.UP * 100,
		_usable.global_position + Vector2.UP * 50,
		Color.GREEN)


func create_line(_from: Vector2, _to: Vector2, _color: Color) -> void:
	var line2D: Line2D = Line2D.new()
	line2D.add_point(_from)
	line2D.add_point(_to)
	line2D.width = 5
	line2D.default_color = _color
	add_child(line2D)
	
	await get_tree().create_timer(0.08).timeout
	line2D.queue_free()


func _ready() -> void:
	Game.instance.enemy_added.connect(on_enemy_added)
	Game.instance.usable_added.connect(on_usable_added)
