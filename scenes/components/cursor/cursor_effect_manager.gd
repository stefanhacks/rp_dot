class_name CursorEffectManager
extends Node

const CURSOR_BREADCRUMB = preload('res://scenes/components/cursor/cursor_breadcrumb.tscn')
const SEGMENT_AMOUNT = 15.0

var effect: Effect = Effect.NONE
var source_position: Vector2
var target_nodes: Array[Node2D]

enum Effect {
	NONE,
	TARGETING,
}


func _ready() -> void:
	for i in range(SEGMENT_AMOUNT):
		var breadcrumb = CURSOR_BREADCRUMB.instantiate()
		breadcrumb.visible = false
		target_nodes.push_back(breadcrumb)
		add_child(breadcrumb)


func _physics_process(_delta: float) -> void:
	match effect:
		Effect.TARGETING: _update_targeting_effect()
		Effect.NONE, _: pass


func _set_breadcrumbs_visible(status: bool = true) -> void:
	for node in target_nodes:
		node.visible = status


func enable_targeting_effect(from: Vector2) -> void:
	_set_breadcrumbs_visible()
	source_position = from
	effect = Effect.TARGETING


func disable_targeting_effect() -> void:
	_set_breadcrumbs_visible(false)
	effect = Effect.NONE


func _update_targeting_effect() -> void:
	var cursor_position = get_viewport().get_mouse_position()
	var difference = cursor_position - source_position
	
	for i in range(SEGMENT_AMOUNT):
		var progress = i / (SEGMENT_AMOUNT - 1)
		var eased_position = Vector2(
			difference.x * ease(progress, 1.0),
			difference.y * ease(progress, 0.4),
		)
		target_nodes[i].position = source_position + eased_position
