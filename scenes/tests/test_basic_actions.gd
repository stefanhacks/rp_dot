extends Node

@export var a_star_manager: AStarManager
@export var breadcrumb_tracker: BreadcrumbTracker

@export var map_markers: TileMapLayer
@export var terrain_markers: TileMapLayer
@export var characters: Array[Character]
@export var character: CharacterPlayable

var targeted_cell := -Vector2i.ONE
var cells_per_second = 5.0
var walking_path = []
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
		if walking_path.size() == 0:
			_place_target(clicked_cell)
		elif clicked_cell == targeted_cell:
			_move_to(clicked_cell)


func _attempt_click_on_character(target_cell: Vector2) -> bool:
	for node in characters:
		var character_cell = map_markers.local_to_map(node.global_position)
		if character_cell.distance_to(target_cell) == 0:
			return true
	return false


func _get_path_to(target_cell: Vector2) -> Array[Vector2i]:
	var walk_distance = character.get_total_value(Ruleset.Stat.WALK)
	var run_distance = character.get_total_value(Ruleset.Stat.RUN)
	var allowed_distance = walk_distance + run_distance
	
	var sprite_cell = map_markers.local_to_map(character.global_position)
	var path := a_star_manager.get_path_on_grid(sprite_cell, target_cell).slice(1, allowed_distance + 1)
	
	if path.size() > walk_distance and path.size() <= allowed_distance:
		breadcrumb_tracker.modulate = Color.CORAL
	else:
		breadcrumb_tracker.modulate = Color.MEDIUM_SPRING_GREEN
	
	return path


func _move_to(new_target_cell: Vector2) -> void:
	targeted_cell = -Vector2i.ONE
	var path = _get_path_to(new_target_cell)
	
	if path.size() > 0:
		walking_path = path
		_take_step()


func _take_step() -> void:
	if walking_path.size() > 0:
		var new_step = walking_path.pop_front()
		var new_position = a_star_manager.get_centered_position_on_grid(new_step)
		if character.position.x != new_position.x:
			character.scale.x = -1 if character.position.x <= new_position.x else 1
		
		breadcrumb_tracker.remove_first()
		character.position = new_position
		
		walking_timer = get_tree().create_timer(1.0 / cells_per_second)
		walking_timer.timeout.connect(_take_step)


func _place_target(new_target_cell: Vector2) -> void:		
	if a_star_manager.is_point_solid(new_target_cell):
		return
	
	targeted_cell = new_target_cell
	var path = _get_path_to(new_target_cell)
	
	if path.size() > 0:
		breadcrumb_tracker.place_breadcrumbs_on_grid(path, a_star_manager)
