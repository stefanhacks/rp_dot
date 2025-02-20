extends Control

signal button_down
signal button_up
signal pressed
signal toggled


func _on_button_round_button_down() -> void:
	button_down.emit()


func _on_button_round_button_up() -> void:
	button_up.emit()


func _on_button_round_pressed() -> void:
	pressed.emit()


func _on_button_round_toggled(toggled_on: bool) -> void:
	toggled.emit(toggled_on)
