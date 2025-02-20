@tool
class_name CharacterClickable
extends Character

signal clicked
signal mouse_entered
signal mouse_exited

@export var texture: Texture2D:
	set(value):
		if (sprite_node == null): return
		texture = value
		sprite_node.texture = value
@export var texture_dimensions: Vector2i = Vector2i.ONE:
	set(value):
		if (sprite_node == null): return
		texture_dimensions = value
		sprite_node.hframes = value.x
		sprite_node.vframes = value.y
@export var texture_frame: int:
	set(value):
		if (sprite_node == null): return
		var max_value = (sprite_node.vframes * sprite_node.hframes) - 1
		texture_frame = clamp(value, 0, max_value)
		sprite_node.frame = texture_frame

@onready var sprite_node: Sprite2D = $Sprite
@onready var _health_bar: HealthBar = $HealthBarContainer


func _on_area_2d_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if event.is_action_released('left_click'): clicked.emit(self)


func _on_area_2d_mouse_entered() -> void:
	mouse_entered.emit(self)


func _on_area_2d_mouse_exited() -> void:
	mouse_exited.emit(self)


func _on_area_2d_mouse_shape_entered(_shape_idx: int) -> void:
	_health_bar.visible = true
	_health_bar.pips = current_health


func _on_area_2d_mouse_shape_exited(_shape_idx: int) -> void:
	_health_bar.visible = false
