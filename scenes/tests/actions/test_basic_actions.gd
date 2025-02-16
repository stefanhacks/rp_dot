extends Node

@export var a_star_manager: AStarManager
@export var entity_controller: EntityController
@export var map_markers: TileMapLayer
@export var terrain_markers: TileMapLayer

@export var action_walk: ActionStateMachine
@export var action_strike: ActionStateMachine

@export var rogue_a: Node2D
@export var rogue_b: Node2D


var _current_action: ActionStateMachine
var _test_running: bool = false
var _test_stage = 0


func _ready() -> void:
	_setup_grid()
	_current_action = action_walk
	entity_controller.add_playable(rogue_a)
	entity_controller.add_playable(rogue_b)


func _setup_grid() -> void:
	var region = map_markers.get_used_rect()
	var cell_size = Vector2i(32, 32)
	a_star_manager.setup_grid(region, cell_size)
	a_star_manager.add_obstacles(terrain_markers.get_used_cells())


func _process(delta: float) -> void:
	if _test_running:
		_current_action.on_action_process(delta)


func _physics_process(delta: float) -> void:
	if _test_running:
		_current_action.on_action_physics_process(delta)
	elif Input.is_action_just_pressed('left_click'):
		_do_action()


func _do_action() -> void:
	_test_running = true
	_current_action.action_performed.connect(_stop_action)
	_current_action.action_cancelled.connect(_cancel_action)
	_current_action.on_action_ready()


func _cancel_action() -> void:
	_disconnect_current_action()
	_test_running = false


func _stop_action() -> void:
	_disconnect_current_action()
	_test_running = false
	_test_stage = (_test_stage + 1) % 2
	_current_action = action_walk if _test_stage == 0 else action_strike


func _disconnect_current_action() -> void:
	_current_action.action_performed.disconnect(_stop_action)
	_current_action.action_cancelled.disconnect(_cancel_action)
