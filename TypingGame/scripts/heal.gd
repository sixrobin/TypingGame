class_name Heal
extends Usable


func on_text_completed() -> void:
	super.on_text_completed()
	Game.instance.player.heal(5)


func _ready() -> void:
	super._ready()
	typed_text.set_text('heal')
