class_name ActionState
extends NodeState

var a_star_manager: AStarManager
var breadcrumb_tracker: BreadcrumbTracker
var cursor_effect: CursorEffect
var character: Character
var map: Node2D


#region State Machine
func on_process(_delta: float) -> void:
	pass


func on_physics_process(_delta: float) -> void:
	pass


func on_next_transitions() -> void:
	pass


func on_enter(args: Dictionary) -> void:
	a_star_manager = args["a_star_manager"]
	breadcrumb_tracker = args["breadcrumb_tracker"]
	cursor_effect = args["cursor_effect"]
	character = args["character"]
	map = args["map"]


func on_exit() -> void:
	pass


#endregion
