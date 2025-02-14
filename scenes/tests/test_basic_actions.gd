extends Node

@export var a_star_manager: AStarManager
@export var map_markers: TileMapLayer
@export var terrain_markers: TileMapLayer

@export var action_walk: ActionStateMachine

var _test_running: bool = false


func _ready() -> void:
	_setup_grid()


func _setup_grid() -> void:
	var region = map_markers.get_used_rect()
	var cell_size = Vector2i(32, 32)
	a_star_manager.setup_grid(region, cell_size)
	a_star_manager.add_obstacles(terrain_markers.get_used_cells())


func _input(event: InputEvent) -> void:
	if event.is_action_pressed('click') and _test_running == false:
		_do_action()


func _do_action() -> void:
	_test_running = true
	action_walk.action_performed.connect(_stop_action)
	action_walk.on_action_ready()


func _stop_action() -> void:
	_test_running = false


func _process(delta: float) -> void:
	if _test_running:
		action_walk.on_action_process(delta)


func _physics_process(delta: float) -> void:
	if _test_running:
		action_walk.on_action_physics_process(delta)
