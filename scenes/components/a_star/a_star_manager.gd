class_name AStarManager
extends Node

var grid := AStarGrid2D.new()


func setup_grid(region: Rect2i, cell_size: Vector2i, diagonal := AStarGrid2D.DIAGONAL_MODE_NEVER) -> void:
	grid.region = region
	grid.cell_size = cell_size
	grid.diagonal_mode = diagonal
	grid.update()


func is_in_bounds(target_cell: Vector2i) -> bool:
	var x = target_cell.x
	var y = target_cell.y
	
	var within_x = grid.region.position.x <= x and x < grid.region.end.x
	var within_y = grid.region.position.y <= y and y < grid.region.end.y
	return within_x and within_y


func is_point_solid(target_cell: Vector2) -> bool:
	return grid.is_point_solid(target_cell)


func add_obstacle(position: Vector2i) -> void:
	grid.set_point_solid(position)


func add_obstacles(obstacles: Array[Vector2i]) -> void:
	for obstacle in obstacles:
		add_obstacle(obstacle)


func get_path_on_grid(from_cell: Vector2i, to_cell: Vector2i) -> Array[Vector2i]:
	if !is_in_bounds(to_cell):
		return []
	else:
		return grid.get_id_path(from_cell, to_cell)


func get_position_on_grid(from_cell: Vector2i) -> Vector2i:
	return floor(grid.get_point_position(from_cell))


func get_centered_position_on_grid(from_cell: Vector2i) -> Vector2i:
	return floor(get_position_on_grid(from_cell) + Vector2i(grid.cell_size / 2))
