class_name Game
extends Node2D


@onready var player: Player = $Player
@onready var level: Level = $Level

var enemies: Array[Enemy] = []

static var instance: Game = null

signal enemy_added(_enemy: Enemy)
signal enemy_removed(_enemy: Enemy)


func add_enemy(_enemy: Enemy) -> void:
	enemies.append(_enemy)
	enemy_added.emit(_enemy)


func remove_enemy(_enemy: Enemy) -> void:
	enemies.remove_at(enemies.find(_enemy))
	enemy_removed.emit(_enemy)


func _enter_tree() -> void:
	instance = self


func _exit_tree() -> void:
	if instance == self:
		instance = null
