extends NodeState

var a_star_manager: AStarManager
var breadcrumb_tracker: BreadcrumbTracker
var character: Character
var map: Node2D
var path: Array[Vector2i]

var cells_per_second = 15.0
var timer = 0.0


#region State Machine
func on_process(_delta : float) -> void:
	pass


func on_physics_process(delta : float) -> void:
	if path.size() == 0:
		transition.emit(ActionStateMachine.PERFORMED)
	elif timer == 0:
		_take_step()
	else:
		timer = max(0.0, timer - delta)


func on_next_transitions() -> void:
	pass


func on_enter(args: Dictionary) -> void:
	a_star_manager = args["a_star_manager"]
	breadcrumb_tracker = args["breadcrumb_tracker"]
	character = args["character"]
	map = args["map"]
	path = args["path"]


func on_exit() -> void:
	pass


#endregion
func _take_step() -> void:
	if path.size() > 0:
		var new_step = path.pop_front()
		var new_position = a_star_manager.get_centered_position_on_grid(new_step)
		if character.position.x != new_position.x:
			character.scale.x = -1 if character.position.x <= new_position.x else 1
		
		breadcrumb_tracker.remove_first()
		character.position = new_position
		
		timer = 1.0 / cells_per_second
