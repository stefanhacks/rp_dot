class_name CursorEffect
extends Node

const CURSOR_BREADCRUMB = preload("res://scenes/components/cursor/cursor_breadcrumb.tscn")
const SEGMENT_AMOUNT = 15.0

var effect: Effect = Effect.NONE
var source_position: Vector2

enum Effect {
	NONE,
	TARGETING,
}


func _physics_process(_delta: float) -> void:
	match effect:
		Effect.TARGETING: _update_targeting_effect()
		Effect.NONE, _: pass


func enable_targeting_effect(from: Node2D) -> void:
	source_position = from.global_position
	effect = Effect.TARGETING


func _clear_effect() -> void:
	for child in get_children():
		child.queue_free()


func _update_targeting_effect() -> void:
	_clear_effect()
	var cursor_position = get_viewport().get_mouse_position()
	var difference = cursor_position - source_position
	
	for i in range(SEGMENT_AMOUNT):
		var progress = i / (SEGMENT_AMOUNT - 1)
		var eased_position = Vector2(
			difference.x * ease(progress, 1.0),
			difference.y * ease(progress, 0.4),
		)
		_add_breadcrumb(source_position + eased_position)


func _add_breadcrumb(position: Vector2) -> void:
	var breadcrumb = CURSOR_BREADCRUMB.instantiate()
	breadcrumb.position = position
	add_child(breadcrumb)
