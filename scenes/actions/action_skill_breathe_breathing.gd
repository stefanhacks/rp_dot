extends ActionState


#region State Machine
func on_process(_delta : float) -> void:
	pass


func on_physics_process(_delta : float) -> void:
	pass


func on_next_transitions() -> void:
	pass


func on_enter(args: Dictionary) -> void:
	super(args)
	_breathe()


func on_exit() -> void:
	pass


#endregion
func _breathe() -> void:
	var roll = DiceTray.roll(Ruleset.Dice.D4, 2)
	rogue.heal(roll.total)
	print ("Healed for ", roll.total)
	transition.emit(ActionStateMachine.PERFORMED)
