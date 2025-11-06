class_name LevelView
extends Control


@export var level: Level = null

@onready var progress_bar: ColorRect = $ColorRect


func on_current_level_score_changed(_score: int):
	progress_bar.scale.x = _score / float(level.next_level_score)


func _ready() -> void:
	level.current_level_score_changed.connect(on_current_level_score_changed)
	on_current_level_score_changed(level.current_level_score)
