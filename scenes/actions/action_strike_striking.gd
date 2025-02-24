extends ActionState


# Animation should go in this state.
#region State Machine
func on_process(_delta: float) -> void:
	pass


func on_physics_process(_delta: float) -> void:
	pass


func on_next_transitions() -> void:
	pass


func on_enter(args: Dictionary) -> void:
	super(args)
	print ("Locked in")
	_strike(args['target'])


func on_exit() -> void:
	pass


#endregion
func _strike(target: CharacterFoe) -> void:
	var roll = rogue.roll_for(Ruleset.ActionType.STRIKE)
	if roll.total > target.get_total_value(Ruleset.Stat.STRIKE):
		print("Hit.")
		target.take_damage(rogue.get_total_value(Ruleset.Stat.DAMAGE))
	else:
		print("Miss.")

	transition.emit(ActionStateMachine.PERFORMED)
	
