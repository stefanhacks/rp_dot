extends Node2D

@onready var cursor_effect: CursorEffect = $CursorEffect


func _ready() -> void:
	cursor_effect.enable_targeting_effect(self)


func _physics_process(_delta: float) -> void:
	if Input.is_action_just_pressed('left_click'):
		_on_click()


func _on_click() -> void:
	var mouse_position = get_viewport().get_mouse_position()
	cursor_effect.source_position = mouse_position
