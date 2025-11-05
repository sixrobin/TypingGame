class_name Game
extends Node2D


@onready var player: Player = $Player

static var instance: Game = null


func _enter_tree() -> void:
	instance = self


func _exit_tree() -> void:
	if instance == self:
		instance = null
