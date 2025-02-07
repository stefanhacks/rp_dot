@tool
extends Node2D


func _draw() -> void:
	if Engine.is_editor_hint():
		draw_circle(Vector2i.ZERO, 3, Color.WHITE)
