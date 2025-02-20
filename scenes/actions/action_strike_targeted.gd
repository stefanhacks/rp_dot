extends ActionState

var target: CharacterFoe


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
	ConfirmationPopup.show(_on_confirm, _on_cancel, rogue.global_position + Vector2(0, -50))


func on_exit() -> void:
	pass


#endregion

func _on_confirm() -> void:
	transition.emit('striking', { 'target': target })


func _on_cancel() -> void:
	transition.emit(ActionStateMachine.CANCELLED)
