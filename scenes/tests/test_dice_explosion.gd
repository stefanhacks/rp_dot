extends Control

@export var dice_type: DiceTray.Dice = DiceTray.Dice.D4

var is_exploding = false

@onready var dice_label: Label = $DiceLabel
@onready var results_label: Label = $Results


func _ready() -> void:
	dice_label.text = "D%s:" % dice_type


func _on_button_pressed() -> void:
	DiceTray.explode = true
	var result = DiceTray.roll(dice_type, 3, DiceTray.RollStyle.TWICE_KEEP_HIGH)
	results_label.text = "{0}, {1} + {2}, from {3}".format([result.total, result.sum, result.modifier, " + ".join(result.rolls)])
