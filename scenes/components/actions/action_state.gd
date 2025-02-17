class_name ActionState
extends NodeState

var a_star_manager: AStarManager
var breadcrumb_manager: BreadcrumbManager
var cursor_effect_manager: CursorEffectManager
var entity_manager: EntityManager
var rogue: CharacterRogue
var map: Node2D


#region State Machine
func on_process(_delta: float) -> void:
	pass


func on_physics_process(_delta: float) -> void:
	pass


func on_next_transitions() -> void:
	pass


func on_enter(args: Dictionary) -> void:
	a_star_manager = args['a_star_manager']
	breadcrumb_manager = args['breadcrumb_manager']
	cursor_effect_manager = args['cursor_effect_manager']
	entity_manager = args['entity_manager']
	rogue = args['rogue']
	map = args['map']


func on_exit() -> void:
	pass


#endregion
