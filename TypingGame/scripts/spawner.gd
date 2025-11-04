class_name Spawner
extends Node2D

@export var player: Player = null

var enemy_prefabs: Dictionary[PackedScene, float] = {
	preload('res://prefabs/goblin.tscn'): 3,
	preload('res://prefabs/lich.tscn'): 6,
	preload('res://prefabs/priest.tscn'): 3,
	preload('res://prefabs/skeleton.tscn'): 2,
	preload('res://prefabs/slime.tscn'): 4,
	preload('res://prefabs/demon.tscn') : 0.2,
}

var total_enemies_weight: float = 0


func spawn_enemy() -> Enemy:
	var enemy_prefab: PackedScene = null
	var random_weight: float = randf() * total_enemies_weight
	var current_weight: float = 0
	for enemy in enemy_prefabs.keys():
		current_weight += enemy_prefabs[enemy]
		if current_weight >= random_weight:
			enemy_prefab = enemy
			break
	
	if not enemy_prefab:
		enemy_prefab = enemy_prefabs.keys()[-1]
	
	var enemy_instance: Enemy = enemy_prefab.instantiate() as Enemy
	
	var topside: bool = randf() < 0.5
	var spawn_position: Vector2
	if topside:
		spawn_position = Vector2(randf_range(-1000, 1000), -500 if randf() < 0.5 else 500)
	else:
		spawn_position = Vector2(-1000 if randf() < 0.5 else 1000, randf_range(-500, 500))
	
	enemy_instance.position = spawn_position
	enemy_instance.set_target(player)
	enemy_instance.killed.connect(on_enemy_killed)
	add_child(enemy_instance)
	return enemy_instance


func on_enemy_killed(_enemy: Enemy) -> void:
	spawn_enemy()
	_enemy.killed.disconnect(on_enemy_killed)


func _ready() -> void:
	for weight in enemy_prefabs.values():
		total_enemies_weight += weight
	print(total_enemies_weight)
	
	for i in 30:
		spawn_enemy()
