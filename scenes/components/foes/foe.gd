@tool
class_name Foe
extends CharacterFoe

@export var sprite_index: int:
	set(value):
		if (foe_sprite == null): return
		var max_value = (foe_sprite.vframes * foe_sprite.hframes) - 1
		sprite_index = clamp(value, 0, max_value)
		foe_sprite.frame = sprite_index

@onready var foe_sprite: Sprite2D = $FoeSprite
@onready var area_2d: Area2D = $Area2D


func _on_area_2d_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if event.is_action_released('left_click'): clicked.emit(self)


func _on_area_2d_mouse_entered() -> void:
	mouse_entered.emit(self)


func _on_area_2d_mouse_exited() -> void:
	mouse_exited.emit(self)
