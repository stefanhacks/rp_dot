class_name ActionStateMachine
extends Node

signal action_cancelled
signal action_performed
static var CANCELLED = 'cancelled'
static var PERFORMED = 'performed'

@export var rogue: CharacterRogue

@export var a_star_manager: AStarManager
@export var breadcrumb_manager: BreadcrumbManager
@export var cursor_effect_manager: CursorEffectManager
@export var entity_manager: EntityManager
@export var map: Node2D

@export var _max_uses: int = -1
@export var _reset_uses: ActionRenewUses

var _default_args: Dictionary = {}
var _node_states: Dictionary = {}
var _current_state: NodeState

var _uses_left: int
var _cancel_cleanup: Callable

@onready var _activated_state: = $Activated


func _ready() -> void:
	_uses_left = _max_uses
	_default_args = {
		'a_star_manager': a_star_manager,
		'breadcrumb_manager': breadcrumb_manager,
		'cursor_effect_manager': cursor_effect_manager,
		'entity_manager': entity_manager,
		'rogue': rogue,
		'map': map,
	}
	
	for child in get_children():
		if child is NodeState:
			_node_states[child.name.to_lower()] = child
			child.transition.connect(transition_to)


func renew() -> void:
	if _reset_uses != null:
		_uses_left = _max_uses
	else:
		_uses_left = mini(_max_uses, _reset_uses.get_amount())


#region ActionStateMachine
func on_action_ready() -> void:
	if _max_uses != -1 and _uses_left == 0:
		action_cancelled.emit()
	else:
		_save_what_will_change()
		_current_state = _activated_state
		_activated_state.on_enter(_default_args)


func on_action_process(delta: float) -> void:
	_current_state.on_process(delta)


func on_action_physics_process(delta: float) -> void:
	_current_state.on_physics_process(delta)
	if _current_state != null: 
		_current_state.on_next_transitions()


func transition_to(state_name: String, args: Dictionary = {}) -> void:
	if state_name == _current_state.name.to_lower(): return
	_current_state.on_exit()
	
	if state_name == CANCELLED: _on_cancelled()
	elif state_name == PERFORMED: _on_performed()
	else: _on_transition(state_name, args)


#endregion
func _save_what_will_change() -> void:
	var original_rogue_position = rogue.position
	var original_rogue_scale_x = rogue.scale.x
	
	_cancel_cleanup = func ():
		rogue.position = original_rogue_position
		rogue.scale.x = original_rogue_scale_x


func _on_cancelled() -> void:
	_current_state = null
	_cancel_cleanup.call()
	breadcrumb_manager.clean_breadcrumbs()
	action_cancelled.emit()


func _on_performed() -> void:
	if _uses_left != -1: _uses_left = maxi(0, _uses_left - 1)
	_current_state = null
	action_performed.emit()


func _on_transition(state_name: String, args: Dictionary = {}) -> void:
	var new_state = _node_states.get(state_name.to_lower())
	_current_state = new_state
	args.merge(_default_args)
	new_state.on_enter(args)
