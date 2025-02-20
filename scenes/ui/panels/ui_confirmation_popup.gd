class_name UIConfirmationPopup
extends Panel

signal popup_cancelled
signal popup_confirmed

@export var _question_label: Label
@export var _info_label: Label


func set_question(question: String) -> void:
	_question_label.text = question


func set_info(info: String) -> void:
	_info_label.text = info


func _on_button_cancel_pressed() -> void:
	popup_cancelled.emit()


func _on_button_confirm_pressed() -> void:
	popup_confirmed.emit()
