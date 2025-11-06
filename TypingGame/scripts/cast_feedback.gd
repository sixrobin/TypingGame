class_name CastFeedback
extends Node2D


func on_enemy_added(_enemy: Enemy) -> void:
	_enemy.ready.connect(func(): on_enemy_ready(_enemy))


func on_enemy_ready(_enemy: Enemy) -> void:
	_enemy.typed_text.letter_typed.connect(func(): on_enemy_letter_typed(_enemy))


func on_enemy_letter_typed(_enemy: Enemy) -> void:
	var line2D: Line2D = Line2D.new()
	line2D.add_point(Game.instance.player.global_position + Vector2.UP * 100)
	line2D.add_point(_enemy.global_position + Vector2.UP * 100)
	line2D.width = 5
	line2D.default_color = Color.CORNFLOWER_BLUE
	add_child(line2D)
	
	await get_tree().create_timer(0.08).timeout
	line2D.queue_free()


func _ready() -> void:
	Game.instance.enemy_added.connect(on_enemy_added)
