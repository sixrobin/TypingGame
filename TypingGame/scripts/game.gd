class_name Game
extends Node2D


@onready var player: Player = $Player
@onready var level: Level = $Level

static var instance: Game = null

var enemies: Array[Enemy] = []
var usables: Array[Usable] = []

signal enemy_added(_enemy: Enemy)
signal enemy_removed(_enemy: Enemy)
signal usable_added(_usable: Usable)
signal usable_removed(_usable: Usable)


func add_enemy(_enemy: Enemy) -> void:
	enemies.append(_enemy)
	enemy_added.emit(_enemy)


func remove_enemy(_enemy: Enemy) -> void:
	enemies.remove_at(enemies.find(_enemy))
	enemy_removed.emit(_enemy)


func add_usable(_usable: Usable) -> void:
	usables.append(_usable)
	usable_added.emit(_usable)


func remove_usable(_usable: Usable) -> void:
	usables.remove_at(usables.find(_usable))
	usable_removed.emit(_usable)


func _enter_tree() -> void:
	instance = self


func _exit_tree() -> void:
	if instance == self:
		instance = null
