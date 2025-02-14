class_name ActionStateMachine
extends Node

signal action_cancelled
signal action_performed

@export var a_star_manager: AStarManager
@export var breadcrumb_tracker: BreadcrumbTracker
@export var character: CharacterPlayable
@export var map: Node2D

@export var max_uses: int = -1
@export var reset_uses: ActionRenewUses

@export var activated_state: NodeState

var default_args: Dictionary = {}
var node_states: Dictionary = {}
var current_state: NodeState
var uses_left: int

static var CANCELLED = "cancelled"
static var PERFORMED = "performed"


func _ready() -> void:
	uses_left = max_uses
	default_args = {
		"a_star_manager": a_star_manager,
		"breadcrumb_tracker": breadcrumb_tracker,
		"character": character,
		"map": map,
	}
	for child in get_children():
		if child is NodeState:
			node_states[child.name.to_lower()] = child
			child.transition.connect(transition_to)


func on_action_ready() -> void:
	if max_uses != -1 and uses_left == 0:
		action_cancelled.emit()
	else:
		current_state = activated_state
		activated_state.on_enter(default_args)


func on_action_process(delta: float) -> void:
	current_state.on_process(delta)


func on_action_physics_process(delta: float) -> void:
	current_state.on_physics_process(delta)
	if current_state != null: 
		current_state.on_next_transitions()


func transition_to(state_name: String, args: Dictionary = {}) -> void:
	if state_name == current_state.name.to_lower():
		return
	
	current_state.on_exit()
	
	if state_name == CANCELLED:
		current_state = null
		action_cancelled.emit()
	elif state_name == PERFORMED:
		if uses_left != -1: uses_left = maxi(0, uses_left - 1)
		current_state = null
		action_performed.emit()
	else:
		var new_state = node_states.get(state_name.to_lower())
		current_state = new_state
		args.merge(default_args)
		new_state.on_enter(args)


func renew() -> void:
	if reset_uses != null:
		uses_left = max_uses
	else:
		uses_left = mini(max_uses, reset_uses.get_amount())
