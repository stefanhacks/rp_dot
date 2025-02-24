extends Node

const UI_CONFIRMATION_POPUP = preload("res://scenes/ui/panels/ui_confirmation_popup.tscn")
var _node: UIConfirmationPopup
var _confirm_call
var _cancel_call


func _ready() -> void:
	_node = UI_CONFIRMATION_POPUP.instantiate()


func show(confirm_call: Callable, cancel_call: Callable, prompt: String, position = null) -> void:
	var ui = get_tree().get_first_node_in_group("ui")
	ui.add_child(_node)
	
	_node.global_position = position if position != null else get_viewport().size / 2
	_node.global_position -= _node.size / 2
	
	_confirm_call = confirm_call
	_cancel_call = cancel_call
	_node.set_question(prompt)
	_node.popup_confirmed.connect(_on_confirm)
	_node.popup_cancelled.connect(_on_cancel)


func _on_confirm() -> void:
	_confirm_call.call()
	clear()


func _on_cancel() -> void:
	_cancel_call.call()
	clear()


func clear() -> void:
	_node.popup_confirmed.disconnect(_on_confirm)
	_node.popup_cancelled.disconnect(_on_cancel)
	_confirm_call = null
	_cancel_call = null
	
	var ui = get_tree().get_first_node_in_group("ui")
	ui.remove_child(_node)
