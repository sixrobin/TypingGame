class_name Cross
extends Usable


func on_text_completed() -> void:
	super.on_text_completed()
	
	for enemy in Game.instance.enemies:
		enemy.typed_text.type_next_letter()


func _ready() -> void:
	super._ready()
	typed_text.set_text('cross')
