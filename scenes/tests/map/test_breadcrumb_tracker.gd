extends Node2D

@onready var a_star_manager: AStarManager = $AStarManager
@onready var breadcrumb_manager: BreadcrumbManager = $BreadcrumbManager
@onready var breadcrumb_manager_2: BreadcrumbManager = $BreadcrumbManager2


func _ready() -> void:
	_test()
	_test_placing()


func _test() -> void:
	for i in range(5):
		var point_position = Vector2i(50 * (i + 1) + 200, 100)
		breadcrumb_manager.place_breadcrumb(point_position, i as Breadcrumb.Indication)


func _test_placing() -> void:
	var cell_size = Vector2i(32, 32)
	var region = Rect2i(2, 4, 21, 10)
	a_star_manager.setup_grid(region, cell_size)
	
	var cell_positions: Array[Vector2i] = []
	cell_positions.assign((range(6, 18)).map(func(value: int): return Vector2i(value, 6)))
	var positions = a_star_manager.path_to_centered_position_on_grid(cell_positions as Array[Vector2i])

	breadcrumb_manager_2.place_breadcrumbs_on_grid(positions, 5, 3)
