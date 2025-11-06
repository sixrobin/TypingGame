class_name Level
extends Node2D


var level_index: int = 0
var score: int = 0
var current_level_score: int = 0
var next_level_score: int = 0
var last_level_reached: bool = false

var level_scores: Array[int] = [
	200,
	500,
	1000,
	2000,
	5000,
	10000,
]

signal current_level_score_changed(_score: int)


func add_score(_amount: int) -> void:
	score += _amount
	current_level_score += _amount
	
	if level_index < level_scores.size() and current_level_score > next_level_score:
		level_index += 1
		last_level_reached = level_index == level_scores.size()
		
		if last_level_reached:
			print('Last level reached')
		else:
			current_level_score = 0
			next_level_score = level_scores[level_index]
	
	current_level_score_changed.emit(current_level_score)


func _ready() -> void:
	next_level_score = level_scores[0]
