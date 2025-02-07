class_name AStarManager
extends Node

@export var map_markers: TileMapLayer
@export var terrain_markers: TileMapLayer
@export var test_sprite: Node2D
@export var selected_pointer: Node2D
@export var confirmed_pointer: Node2D

const BREADCRUMB = preload("res://scenes/components/breadcrumb.tscn")

var grid := AStarGrid2D.new()
var targeted_cell := -Vector2i.ONE
var confirmed_cell := -Vector2i.ONE
var breadcrumbs : Array[Node]

var cells_per_second = 5.0
var testing_path = []
var walking_timer: SceneTreeTimer


func _ready() -> void:
	_setup_grid()


func _setup_grid() -> void:
	grid.region = map_markers.get_used_rect()
	grid.cell_size = Vector2i(32, 32)
	grid.diagonal_mode = AStarGrid2D.DIAGONAL_MODE_NEVER
	grid.update()
	
	for point in terrain_markers.get_used_cells():
		grid.set_point_solid(point)


func _input(event: InputEvent) -> void:
	if event.is_action_pressed('click'):
		_click()


func _click() -> void:
	var clicked_cell = map_markers.local_to_map(map_markers.get_local_mouse_position())
	if _is_in_bounds(clicked_cell):
		if clicked_cell == targeted_cell:
			_move_to(clicked_cell)
		else:
			_place_target(clicked_cell)


func _is_in_bounds(target_cell: Vector2i) -> bool:
	var x = target_cell.x
	var y = target_cell.y
	
	var within_x = grid.region.position.x <= x and x < grid.region.end.x
	var within_y = grid.region.position.y <= y and y < grid.region.end.y
	return within_x and within_y


func _move_to(new_target_cell: Vector2) -> void:
	if walking_timer != null and walking_timer.is_connected('timeout', _take_step):
		walking_timer.timeout.disconnect(_take_step)

	selected_pointer.visible = false
	targeted_cell = -Vector2i.ONE
	confirmed_cell = new_target_cell
	
	_clean_breadcrumbs()
	_place_target(confirmed_cell, true)
	
	var sprite_cell = map_markers.local_to_map(test_sprite.global_position)
	var path = grid.get_id_path(sprite_cell, confirmed_cell)
	if path.size() > 0:
		testing_path = path
		_place_breadcrumbs()
		_take_step()


func _take_step() -> void:
	if testing_path.size() > 0:
		var new_step = testing_path.pop_front()
		var new_position = grid.get_point_position(new_step) + Vector2(16, 16)
		if test_sprite.position.x != new_position.x:
			test_sprite.scale.x = -1 if test_sprite.position.x <= new_position.x else 1
		
		breadcrumbs.pop_front().queue_free()
		
		test_sprite.position = new_position
		walking_timer = get_tree().create_timer(1.0 / cells_per_second)
		walking_timer.timeout.connect(_take_step)
	else:
		confirmed_cell = -Vector2i.ONE
		confirmed_pointer.visible = false


func _place_target(new_target_cell: Vector2, confirmed = false) -> void:
	if grid.is_point_solid(new_target_cell):
		return
	
	var new_target_position = map_markers.map_to_local(new_target_cell)
	var pointer = confirmed_pointer if confirmed else selected_pointer
	
	targeted_cell = new_target_cell
	pointer.position = new_target_position
	pointer.visible = true


func _clean_breadcrumbs() -> void:
	for breadcrumb in breadcrumbs:
		breadcrumb.queue_free()
	
	breadcrumbs = []


func _place_breadcrumbs() -> void:
	breadcrumbs = []
	for point in testing_path:
		var breadcrumb_position = map_markers.map_to_local(point)
		var breadcrumb = BREADCRUMB.instantiate()
		add_child(breadcrumb)
		breadcrumb.position = breadcrumb_position
		breadcrumbs.append(breadcrumb)
