extends Node2D

@onready var cursor_effect_manager: CursorEffectManager = $CursorEffectManager


func _physics_process(_delta: float) -> void:
	if Input.is_action_just_pressed('left_click'):
		_on_left_click()
	elif Input.is_action_just_pressed('right_click'):
		_on_right_click()


func _on_left_click() -> void:
	var mouse_position = get_viewport().get_mouse_position()
	cursor_effect_manager.enable_targeting_effect(mouse_position)


func _on_right_click() -> void:
	cursor_effect_manager.disable_targeting_effect()
