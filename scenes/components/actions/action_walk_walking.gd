extends ActionState

const CELLS_PER_SECOND = 15.0
var path: Array[Vector2i]

var _timer = 0.0


#region State Machine
func on_physics_process(delta : float) -> void:
	if Input.is_action_just_pressed('right_click'):
		transition.emit(ActionStateMachine.CANCELLED)
	elif path.size() == 0:
		transition.emit(ActionStateMachine.PERFORMED)
	elif _timer == 0:
		_take_step()
	else:
		_timer = max(0.0, _timer - delta)


func on_enter(args: Dictionary) -> void:
	super(args)
	path = args['path']


func on_exit() -> void:
	_timer = 0.0
	path = []


#endregion
func _take_step() -> void:
	if path.size() > 0:
		var new_step = path.pop_front()
		var new_position = a_star_manager.get_centered_position_on_grid(new_step)
		if rogue.position.x != new_position.x:
			rogue.scale.x = -1 if rogue.position.x <= new_position.x else 1
		
		breadcrumb_manager.remove_first()
		rogue.position = new_position
		
		_timer = 1.0 / CELLS_PER_SECOND
