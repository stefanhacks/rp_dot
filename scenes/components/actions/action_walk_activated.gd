extends ActionState

var targeted_cell = -Vector2i.ONE

#region State Machine
func on_physics_process(_delta : float) -> void:
	if Input.is_action_just_pressed('left_click'):
		_on_click()
	elif Input.is_action_just_pressed('right_click'):
		transition.emit(ActionStateMachine.CANCELLED)


func on_exit() -> void:
	targeted_cell = -Vector2i.ONE


#endregion
func _on_click() -> void:
	var clicked_cell = map.local_to_map(map.get_local_mouse_position()) as Vector2i
	if get_parent().a_star_manager.is_in_bounds(clicked_cell):
		if clicked_cell == targeted_cell:
			_move_to(clicked_cell)
		else:
			_place_target(clicked_cell)


func _get_path_to(target_cell: Vector2) -> Array[Vector2i]:
	var sprite_cell = map.local_to_map(character.global_position)
	var walk_distance = character.get_total_value(Ruleset.Stat.WALK)
	var run_distance = character.get_total_value(Ruleset.Stat.RUN)
	
	var path = a_star_manager.get_path_on_grid(sprite_cell, target_cell).slice(1, walk_distance + run_distance + 1)
	
	return path


func _place_target(new_target_cell: Vector2i) -> void:
	if get_parent().a_star_manager.is_point_solid(new_target_cell):
		return
	
	targeted_cell = new_target_cell
	
	var path = _get_path_to(new_target_cell)
	if path.size() > 0:
		var walk = character.get_total_value(Ruleset.Stat.WALK)
		var run = character.get_total_value(Ruleset.Stat.RUN)
		breadcrumb_tracker.place_breadcrumbs_on_grid(path, walk, run)


func _move_to(new_target_cell: Vector2) -> void:
	transition.emit("walking", { 'path': _get_path_to(new_target_cell) })
