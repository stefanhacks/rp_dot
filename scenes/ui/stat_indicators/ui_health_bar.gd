@tool
extends Panel

const UI_HEALTH_PIP = preload("res://scenes/ui/indicators/ui_health_pip.tscn")
const MAX_PIPS = 10

@export var pips = 0:
	set(value):
		pips = clampi(value, 0, MAX_PIPS)
		_update_pips()
		_resize_based_on_pips()
@onready var _health_bar: FlowContainer = $HealthBar

var _pip_node_pool = []
var _pip_height: int


func _ready() -> void:
	if _health_bar == null: return
	for child in _health_bar.get_children():
		_pip_node_pool.push_front(child)
		_health_bar.remove_child(child)
	
	for i in range(0, 10 - _pip_node_pool.size()):
		var new_pip = UI_HEALTH_PIP.instantiate()
		_pip_node_pool.push_front(new_pip)
	
	_update_pips()
	_resize_based_on_pips()


func _update_pips() -> void:
	if _health_bar == null: return
	var cur_pips = _health_bar.get_child_count()
	var delta_pip = pips - cur_pips
	
	if delta_pip > 0:
		for i in range(delta_pip):
			_health_bar.add_child(_pip_node_pool.pop_front())
	elif delta_pip < 0:
		for i in range(-delta_pip):
			_pip_node_pool.push_front(_health_bar.get_child(0))
			_health_bar.remove_child(_pip_node_pool[0])


func _resize_based_on_pips() -> void:
	size = custom_minimum_size
	if pips > 5:
		var pip = _health_bar.get_child(0) as TextureRect
		size.y += pip.size.y
