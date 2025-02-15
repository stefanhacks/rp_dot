extends ActionState


#region State Machine
func on_process(_delta: float) -> void:
	pass


func on_physics_process(_delta : float) -> void:
	if Input.is_action_just_pressed('left_click'):
		_on_click()
	elif Input.is_action_just_pressed('right_click'):
		transition.emit(ActionStateMachine.CANCELLED)


#endregion
func _on_click() -> void:
	pass
