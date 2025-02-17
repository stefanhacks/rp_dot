class_name AStarManager
extends Node

var _grid := AStarGrid2D.new()


func setup_grid(region: Rect2i, cell_size: Vector2i, diagonal := AStarGrid2D.DIAGONAL_MODE_NEVER) -> void:
	_grid.region = region
	_grid.cell_size = cell_size
	_grid.diagonal_mode = diagonal
	_grid.update()


func is_in_bounds(target_cell: Vector2i) -> bool:
	# Could not get AStargrid2D own method to work. Figured it was easy enough to algo it myself.
	var x = target_cell.x
	var y = target_cell.y
	
	var within_x = _grid.region.position.x <= x and x < _grid.region.end.x
	var within_y = _grid.region.position.y <= y and y < _grid.region.end.y
	return within_x and within_y


func is_point_solid(target_cell: Vector2) -> bool:
	return _grid.is_point_solid(target_cell)


func set_obstacle(position: Vector2i, solid = true) -> void:
	_grid.set_point_solid(position, solid)


func set_obstacles(obstacles: Array[Vector2i], solid = true) -> void:
	for obstacle in obstacles:
		set_obstacle(obstacle, solid)


func get_path_on_grid(from_cell: Vector2i, to_cell: Vector2i) -> Array[Vector2i]:
	if !is_in_bounds(to_cell):
		return []
	else:
		return _grid.get_id_path(from_cell, to_cell)


func get_position_on_grid(from_cell: Vector2i) -> Vector2i:
	return floor(_grid.get_point_position(from_cell))


func get_centered_position_on_grid(from_cell: Vector2i) -> Vector2i:
	# Essentially, returns the center of a cell based on its size.
	return floor(get_position_on_grid(from_cell) + Vector2i(_grid.cell_size / 2))


func path_to_centered_position_on_grid(path: Array[Vector2i]) -> Array[Vector2i]:
	var positions: Array[Vector2i] = []
	for cell in path:
		positions.append(get_centered_position_on_grid(cell))

	return positions
