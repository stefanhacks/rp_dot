class_name BreadcrumbTracker
extends Node

const BREADCRUMB = preload("res://scenes/components/breadcrumbs/breadcrumb.tscn")


func remove_first() -> void:
	var first = get_children().pop_front()
	first.free()


func clean_breadcrumbs() -> void:
	for breadcrumb in get_children():
		breadcrumb.free()


func place_breadcrumb(position: Vector2i, is_target: bool) -> void:
	var breadcrumb = BREADCRUMB.instantiate()
	breadcrumb.position = position
	breadcrumb.is_target = is_target
	add_child(breadcrumb)


func place_breadcrumbs_on_grid(cell_positions: Array[Vector2i], a_star_manager: AStarManager) -> void:
	clean_breadcrumbs()
	var index = 0
	for cell in cell_positions:
		index += 1
		var breadcrumb_position = a_star_manager.get_centered_position_on_grid(cell)
		var is_target = index == cell_positions.size()
		place_breadcrumb(breadcrumb_position, is_target)
