extends ActionState


#region State Machine
func on_process(_delta: float) -> void:
	pass


func on_enter(args: Dictionary) -> void:
	super(args)
	cursor_effect_manager.enable_targeting_effect(rogue.global_position)
	entity_manager.foe_clicked.connect(_try_to_target)


func on_physics_process(_delta : float) -> void:
	_turn_to_mouse()
	if Input.is_action_just_pressed('left_click'):
		_on_click()
	elif Input.is_action_just_pressed('right_click'):
		transition.emit(ActionStateMachine.CANCELLED)


func on_exit() -> void:
	entity_manager.foe_clicked.disconnect(_try_to_target)
	cursor_effect_manager.disable_targeting_effect()


#endregion
func _on_click() -> void:
	pass


func _turn_to_mouse() -> void:
	var mouse_position = get_viewport().get_mouse_position()
	rogue.sprite_node.scale.x = 1 if mouse_position.x < rogue.position.x else -1


func _try_to_target(node: Character) -> void:
	if node.id != rogue.id: # add range
		var target_cell = map.local_to_map(node.global_position) as Vector2i
		var self_cell = map.local_to_map(rogue.global_position) as Vector2i
		var distance = floori(target_cell.distance_to(self_cell))
		if distance == 1:
			transition.emit('targeted', { 'target': node })
