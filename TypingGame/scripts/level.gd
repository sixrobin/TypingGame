class_name Level
extends Node2D


var level_index: int = 0
var score: int = 0
var current_level_score: int = 0
var next_level_score: int = 0
var last_level_reached: bool = false

var level_scores: Array[int] = [
	100,
	250,
	#500,
	#800,
	#1500,
	#3000,
]


func add_score(_amount: int) -> void:
	score += _amount
	current_level_score += _amount
	
	if level_index < level_scores.size() and current_level_score > next_level_score:
		level_index += 1
		last_level_reached = level_index == level_scores.size()
		
		if last_level_reached:
			print('last level')
		else:
			current_level_score = 0
			next_level_score = level_scores[level_index]


func _ready() -> void:
	next_level_score = level_scores[0]
