class_name BreadcrumbManager
extends Node

const BREADCRUMB = preload('res://scenes/components/breadcrumbs/breadcrumb.tscn')
const BREADCRUMB_AMOUNT = 10

@export var walk_color: Color = Color.MEDIUM_SPRING_GREEN
@export var run_color: Color = Color.CORAL
@export var x_color: Color = Color.REBECCA_PURPLE

var breadcrumb_pool: Array[Node2D]
var used_nodes: Array[Node2D]


func _ready() -> void:
	for i in range(BREADCRUMB_AMOUNT):
		var node = _make_breadcrumb_node()
		breadcrumb_pool.push_back(node)


func _make_breadcrumb_node() -> Node2D:
	var node = BREADCRUMB.instantiate()
	node.visible = false
	add_child(node)
	return node


func get_breadcrumb_node() -> Node2D:
	var node = breadcrumb_pool.pop_front()
	if node == null: node = _make_breadcrumb_node()
	
	used_nodes.push_back(node)
	node.visible = true
	return node


func _clean_breadcrumb(node: Node) -> void:
	node.visible = false
	breadcrumb_pool.push_back(node)


func clean_breadcrumbs() -> void:
	for i in range(used_nodes.size()):
		remove_first()


func remove_first() -> void:
	var node = used_nodes.pop_front()
	_clean_breadcrumb(node)


func place_breadcrumb(at_position: Vector2i, indication: Breadcrumb.Indication) -> void:
	var breadcrumb = get_breadcrumb_node()
	breadcrumb.position = at_position
	breadcrumb.kind = indication
	
	var is_walk = indication == Breadcrumb.Indication.WALK or indication == Breadcrumb.Indication.WALK_END
	var is_run = indication == Breadcrumb.Indication.RUN or indication == Breadcrumb.Indication.RUN_END
	breadcrumb.modulate = walk_color if is_walk else run_color if is_run else x_color


func place_breadcrumbs_on_grid(breadcrumb_positions: Array, walk_limit: int, run_limit: int) -> void:
	clean_breadcrumbs()
	
	var index = 0
	var get_indication: Callable = func (walk_index: int) -> Breadcrumb.Indication:
		if walk_index < walk_limit: return Breadcrumb.Indication.WALK
		elif walk_index == walk_limit: return Breadcrumb.Indication.WALK_END
		elif walk_index < walk_limit + run_limit: return Breadcrumb.Indication.RUN
		elif walk_index == walk_limit + run_limit: return Breadcrumb.Indication.RUN_END
		elif walk_index == walk_limit + run_limit + 1: return Breadcrumb.Indication.TARGET
		else: return Breadcrumb.Indication.MARK
	
	for position in breadcrumb_positions:
		index += 1
		place_breadcrumb(position, get_indication.call(index))
