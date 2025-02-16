extends ActionState

var target: CharacterFoe


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
	target = args['target']
	print ("Locked in")
	_strike()
	transition.emit(ActionStateMachine.PERFORMED)


func on_exit() -> void:
	pass


#endregion
func _strike() -> void:
	var roll = rogue.roll_for(Ruleset.ActionType.STRIKE)
	if roll.total > target.stats.get_value(Ruleset.Stat.STRIKE):
		print("Hit.")
		target.take_damage(rogue.get_total_value(Ruleset.Stat.DAMAGE))
	else:
		print("Miss.")
