@tool
class_name CharacterClickable
extends Character

signal clicked
signal mouse_entered
signal mouse_exited

@export var texture: Texture2D:
	set(value):
		if (_sprite_node == null): return
		texture = value
		_sprite_node.texture = value
@export var texture_dimensions: Vector2i = Vector2i.ONE:
	set(value):
		if (_sprite_node == null): return
		texture_dimensions = value
		_sprite_node.hframes = value.x
		_sprite_node.vframes = value.y
@export var texture_frame: int:
	set(value):
		if (_sprite_node == null): return
		var max_value = (_sprite_node.vframes * _sprite_node.hframes) - 1
		texture_frame = clamp(value, 0, max_value)
		_sprite_node.frame = texture_frame

@onready var _sprite_node: Sprite2D = $Sprite


func _on_area_2d_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if event.is_action_released('left_click'): clicked.emit(self)


func _on_area_2d_mouse_entered() -> void:
	mouse_entered.emit(self)


func _on_area_2d_mouse_exited() -> void:
	mouse_exited.emit(self)
