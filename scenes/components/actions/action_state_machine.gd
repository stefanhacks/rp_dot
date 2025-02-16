class_name ActionStateMachine
extends Node

signal action_cancelled
signal action_performed
static var CANCELLED = 'cancelled'
static var PERFORMED = 'performed'

@export var rogue: Rogue

@export var a_star_manager: AStarManager
@export var breadcrumb_manager: BreadcrumbManager
@export var cursor_effect_manager: CursorEffectManager
@export var entity_manager: EntityManager
@export var map: Node2D

@export var max_uses: int = -1
@export var reset_uses: ActionRenewUses

@export var activated_state: NodeState

var default_args: Dictionary = {}
var node_states: Dictionary = {}
var current_state: NodeState

var uses_left: int
var cancel_cleanup: Callable


func _ready() -> void:
	uses_left = max_uses
	default_args = {
		'a_star_manager': a_star_manager,
		'breadcrumb_manager': breadcrumb_manager,
		'cursor_effect_manager': cursor_effect_manager,
		'entity_manager': entity_manager,
		'rogue': rogue,
		'map': map,
	}
	
	for child in get_children():
		if child is NodeState:
			node_states[child.name.to_lower()] = child
			child.transition.connect(transition_to)


func renew() -> void:
	if reset_uses != null:
		uses_left = max_uses
	else:
		uses_left = mini(max_uses, reset_uses.get_amount())


func on_action_ready() -> void:
	if max_uses != -1 and uses_left == 0:
		action_cancelled.emit()
	else:
		_save_what_will_change()
		current_state = activated_state
		activated_state.on_enter(default_args)


func on_action_process(delta: float) -> void:
	current_state.on_process(delta)


func on_action_physics_process(delta: float) -> void:
	current_state.on_physics_process(delta)
	if current_state != null: 
		current_state.on_next_transitions()


func transition_to(state_name: String, args: Dictionary = {}) -> void:
	if state_name == current_state.name.to_lower(): return
	current_state.on_exit()
	
	if state_name == CANCELLED: _on_cancelled()
	elif state_name == PERFORMED: _on_performed()
	else: _on_transition(state_name, args)


func _save_what_will_change() -> void:
	var original_rogue_position = rogue.position
	var original_rogue_scale_x = rogue.scale.x
	
	cancel_cleanup = func ():
		rogue.position = original_rogue_position
		rogue.scale.x = original_rogue_scale_x


func _on_cancelled() -> void:
	current_state = null
	cancel_cleanup.call()
	breadcrumb_manager.clean_breadcrumbs()
	action_cancelled.emit()


func _on_performed() -> void:
	if uses_left != -1: uses_left = maxi(0, uses_left - 1)
	current_state = null
	action_performed.emit()


func _on_transition(state_name: String, args: Dictionary = {}) -> void:
	var new_state = node_states.get(state_name.to_lower())
	current_state = new_state
	args.merge(default_args)
	new_state.on_enter(args)
