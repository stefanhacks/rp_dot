extends Node2D

@export var rogue: Node2D


func _ready() -> void:
	call_deferred("_show")


func _show() -> void:
	ConfirmationPopup.show(confirm, cancel)


func cancel() -> void:
	print("Confirmed")


func confirm() -> void:
	print("Confirmed")
