class_name Shake
extends Node2D

var trauma: float = 0
var duration: float = 0
var timer: float = 0


func shake(_trauma: float, _duration: float) -> Shake:
	trauma = _trauma
	duration = _duration
	timer = duration
	return self


func _process(delta: float) -> void:
	if timer < 0:
		position = Vector2.ZERO
		return
	
	var offset: float = trauma * timer / duration
	var direction: Vector2 = Vector2.RIGHT.rotated(deg_to_rad(randf() * 360))
	position = direction * offset
	
	timer -= delta
