class_name LevelView
extends Control


@export var level: Level = null

@onready var progress_bar: ColorRect = $ColorRect


func _process(_delta: float) -> void:
	progress_bar.scale.x = level.current_level_score / float(level.next_level_score)
	#print('%s / %s' % [level.current_level_score, level.next_level_score])
