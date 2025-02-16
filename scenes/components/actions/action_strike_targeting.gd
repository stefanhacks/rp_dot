extends ActionState


#region State Machine
func on_process(_delta: float) -> void:
	pass


func on_enter(args: Dictionary) -> void:
	super(args)
	cursor_effect.enable_targeting_effect(rogue.global_position)
	entity_controller.entity_clicked.connect(_try_to_target)


func on_physics_process(_delta : float) -> void:
	_turn_to_mouse()
	if Input.is_action_just_pressed('left_click'):
		_on_click()
	elif Input.is_action_just_pressed('right_click'):
		transition.emit(ActionStateMachine.CANCELLED)


#endregion
func _on_click() -> void:
	pass


func _turn_to_mouse() -> void:
	var mouse_position = get_viewport().get_mouse_position()
	rogue.scale.x = 1 if mouse_position.x < rogue.position.x else -1


func _try_to_target(node: Node) -> void:
	print("Targeting ", node)
