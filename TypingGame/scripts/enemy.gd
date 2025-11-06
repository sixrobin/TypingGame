class_name Enemy
extends Node2D


enum TextType
{
	DEFAULT_TEXT,
	RANDOM,
}

@export_group("Text")
@export var text_type: TextType = TextType.DEFAULT_TEXT
@export var text: String = "enemy"
@export var random_text_size: int = 1

@export_group("Motion")
@export var speed: float = 50
@export var recoil: float = 10

@onready var typed_text: TypedText = $Shake/TypedText
@onready var area_2d: Area2D = $Area2D
@onready var shake: Shake = $Shake

var enemy_drops: Dictionary[PackedScene, float] = {
	preload('res://prefabs/heal.tscn'): 2,
	preload('res://prefabs/cross.tscn'): 1,
}

var total_drops_weight: float = 0
var is_dead: bool = false
var target: Node2D = null

signal killed(_enemy: Enemy)


func set_target(_target: Node2D) -> void:
	target = _target


func on_letter_typed() -> void:
	global_position -= (target.global_position - global_position).normalized() * recoil
	shake.shake(8, 0.1)


func on_text_completed() -> void:
	kill()
	
	Game.instance.level.add_score(text.length())
	
	if randf() < 0.05:
		var drop_prefab: PackedScene = null
		var random_weight: float = randf() * total_drops_weight
		var current_weight: float = 0
		for drop in enemy_drops.keys():
			current_weight += enemy_drops[drop]
			if current_weight >= random_weight:
				drop_prefab = drop
				break
		
		if not drop_prefab:
			drop_prefab = drop_prefab.keys()[-1]
		
		var heal_instance = drop_prefab.instantiate()
		Game.instance.add_child(heal_instance)
		heal_instance.global_position = global_position


func kill() -> void:
	is_dead = true
	killed.emit(self)
	
	shake.shake(25, 0.4)
	
	var death_tween: Tween = create_tween()
	death_tween.tween_property(self, 'modulate', Color.BLACK, 1)
	death_tween.tween_callback(queue_free)


func on_area_entered(area: Area2D) -> void:
	var area_parent = area.get_parent()
	if area_parent is Player:
		area_parent.take_damage(10)
		kill()


func _enter_tree() -> void:
	Game.instance.enemies.append(self)


func _exit_tree() -> void:
	Game.instance.enemies.remove_at(Game.instance.enemies.find(self))


func _ready() -> void:
	for weight in enemy_drops.values():
		total_drops_weight += weight
	
	if text_type == TextType.RANDOM:
		text = TypedText.get_random_text(random_text_size)
	
	typed_text.set_text(text)
	typed_text.set_letter_typed(on_letter_typed)
	typed_text.set_completed(on_text_completed)
	typed_text.set_validated_color(Color.RED)
	
	area_2d.area_entered.connect(on_area_entered)


func _process(delta: float) -> void:
	if not is_dead:
		if target != null:
			global_position += (target.global_position - global_position).normalized() * delta * speed
