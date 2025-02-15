extends Node2D

@onready var a_star_manager: AStarManager = $AStarManager
@onready var breadcrumb_tracker: BreadcrumbTracker = $BreadcrumbTracker
@onready var breadcrumb_tracker_2: BreadcrumbTracker = $BreadcrumbTracker2


func _ready() -> void:
	_test()
	_test_placing()


func _test() -> void:
	for i in range(5):
		var point_position = Vector2i(50 * (i + 1) + 200, 100)
		breadcrumb_tracker.place_breadcrumb(point_position, i as Breadcrumb.Indication)


func _test_placing() -> void:
	var cell_size = Vector2i(32, 32)
	var region = Rect2i(2, 4, 21, 10)
	a_star_manager.setup_grid(region, cell_size)
	
	var cell_positions = range(6, 18).map(func(value: int): return Vector2i(value, 6)) as Array[Vector2i]
	breadcrumb_tracker_2.place_breadcrumbs_on_grid(cell_positions, 5, 3)
