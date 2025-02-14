class_name BreadcrumbTracker
extends Node

const BREADCRUMB = preload("res://scenes/components/breadcrumbs/breadcrumb.tscn")

@export var a_star_manager: AStarManager
@export var walk_color: Color = Color.MEDIUM_SPRING_GREEN
@export var run_color: Color = Color.CORAL
@export var x_color: Color = Color.REBECCA_PURPLE


func remove_first() -> void:
	var first = get_children().pop_front()
	first.free()


func clean_breadcrumbs() -> void:
	for breadcrumb in get_children():
		breadcrumb.free()


func place_breadcrumb(at_position: Vector2i, indication: Breadcrumb.Indication) -> void:
	var breadcrumb = BREADCRUMB.instantiate()
	breadcrumb.position = at_position
	breadcrumb.kind = indication
	
	var is_walk = indication == Breadcrumb.Indication.WALK or indication == Breadcrumb.Indication.WALK_END
	var is_run = indication == Breadcrumb.Indication.RUN or indication == Breadcrumb.Indication.RUN_END
	breadcrumb.modulate = walk_color if is_walk else run_color if is_run else x_color
	
	add_child(breadcrumb)


func place_breadcrumbs_on_grid(cell_positions: Array, walk_limit: int, run_limit: int) -> void:
	clean_breadcrumbs()
	
	var index = 0
	var get_indication: Callable = func (walk_index: int) -> Breadcrumb.Indication:
		if walk_index < walk_limit: return Breadcrumb.Indication.WALK
		elif walk_index == walk_limit: return Breadcrumb.Indication.WALK_END
		elif walk_index < walk_limit + run_limit: return Breadcrumb.Indication.RUN
		elif walk_index == walk_limit + run_limit: return Breadcrumb.Indication.RUN_END
		elif walk_index == walk_limit + run_limit + 1: return Breadcrumb.Indication.TARGET
		else: return Breadcrumb.Indication.MARK
	
	for cell in cell_positions:
		index += 1
		var breadcrumb_position = a_star_manager.get_centered_position_on_grid(cell)
		place_breadcrumb(breadcrumb_position, get_indication.call(index))
