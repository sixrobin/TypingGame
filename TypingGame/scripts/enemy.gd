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

@onready var typed_text: TypedText = $Shake/TypedText
@onready var area_2d: Area2D = $Area2D
@onready var shake: Shake = $Shake

var is_dead: bool = false
var target: Node2D = null

signal killed(_enemy: Enemy)


func set_target(_target: Node2D) -> void:
	target = _target


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


func _ready() -> void:
	var final_text: String
	match text_type:
		TextType.DEFAULT_TEXT:
			final_text = text
		TextType.RANDOM:
			final_text = TypedText.get_random_text(random_text_size)
		_:
			final_text = text
	
	typed_text.set_text(final_text)
	typed_text.set_letter_typed(func(): shake.shake(8, 0.1))
	typed_text.set_completed(kill)
	
	area_2d.area_entered.connect(on_area_entered)


func _process(delta: float) -> void:
	if not is_dead:
		if target != null:
			global_position += (target.global_position - global_position).normalized() * delta * speed
