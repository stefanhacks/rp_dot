extends Node

@export var a_star_manager: AStarManager
@export var breadcrumb_tracker: BreadcrumbTracker

@export var map_markers: TileMapLayer
@export var terrain_markers: TileMapLayer
@export var test_sprite: Node2D
@export var selected_pointer: Node2D

var targeted_cell := -Vector2i.ONE
var cells_per_second = 5.0
var testing_path = []
var walking_timer: SceneTreeTimer


func _ready() -> void:
	_setup_grid()


func _setup_grid() -> void:
	var region = map_markers.get_used_rect()
	var cell_size = Vector2i(32, 32)
	a_star_manager.setup_grid(region, cell_size)
	a_star_manager.add_obstacles(terrain_markers.get_used_cells())


func _input(event: InputEvent) -> void:
	if event.is_action_pressed('click'):
		_click()


func _click() -> void:
	var clicked_cell = map_markers.local_to_map(map_markers.get_local_mouse_position())
	if a_star_manager.is_in_bounds(clicked_cell):
		if clicked_cell == targeted_cell:
			_move_to(clicked_cell)
		else:
			_place_target(clicked_cell)


func _move_to(new_target_cell: Vector2) -> void:
	if walking_timer != null:
		walking_timer.timeout.disconnect(_take_step)
	
	selected_pointer.visible = false
	targeted_cell = -Vector2i.ONE
	
	var sprite_cell = map_markers.local_to_map(test_sprite.global_position)
	var path := a_star_manager.get_path_on_grid(sprite_cell, new_target_cell)
	if path.size() > 0:
		testing_path = path
		breadcrumb_tracker.place_breadcrumbs_on_grid(path, a_star_manager)
		_take_step()


func _take_step() -> void:
	return
	if testing_path.size() > 0:
		var new_step = testing_path.pop_front()
		var new_position = a_star_manager.get_centered_position_on_grid(new_step)
		if test_sprite.position.x != new_position.x:
			test_sprite.scale.x = -1 if test_sprite.position.x <= new_position.x else 1
		
		#breadcrumb_tracker.remove_first()
		test_sprite.position = new_position
		
		walking_timer = get_tree().create_timer(1.0 / cells_per_second)
		walking_timer.timeout.connect(_take_step)


func _place_target(new_target_cell: Vector2) -> void:
	if a_star_manager.is_point_solid(new_target_cell):
		return
	
	targeted_cell = new_target_cell
	selected_pointer.position = map_markers.map_to_local(new_target_cell)
	selected_pointer.visible = true
