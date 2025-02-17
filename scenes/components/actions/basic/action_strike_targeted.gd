extends ActionState

var target: CharacterFoe


#region State Machine
func on_process(_delta: float) -> void:
	pass


func on_physics_process(_delta: float) -> void:
	if Input.is_action_just_pressed('left_click'):
		transition.emit('striking', { 'target': target })
	elif Input.is_action_just_pressed('right_click'):
		transition.emit(ActionStateMachine.CANCELLED)


func on_next_transitions() -> void:
	pass


func on_enter(args: Dictionary) -> void:
	super(args)
	target = args['target']
	print("Waiting for confirm.")


func on_exit() -> void:
	pass


#endregion
