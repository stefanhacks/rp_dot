extends Control

@export var dice_type: Ruleset.Dice = Ruleset.Dice.D4

var is_exploding = false

@onready var dice_label: Label = $DiceLabel
@onready var results_label: Label = $Results


func _ready() -> void:
	dice_label.text = "D%s:" % dice_type


func _on_button_pressed() -> void:
	var result = DiceTray.roll(dice_type, 3, Ruleset.RollStyle.TWICE_KEEP_HIGH, true)
	results_label.text = "{0}, {1} + {2}, from {3}".format([result.total, result.sum, result.modifier, " + ".join(result.rolls)])
