@tool
class_name Knack
extends Resource

# Accessors
@export var strike: Ruleset.Dice = Ruleset.Dice.D4: # Basic attack die.
	set(value): set_value(Ruleset.ActionType.STRIKE, value)
	get(): return get_value(Ruleset.ActionType.STRIKE)
@export var defend: Ruleset.Dice = Ruleset.Dice.D4: # Basic protect self from monsters die.
	set(value): set_value(Ruleset.ActionType.DEFEND, value)
	get(): return get_value(Ruleset.ActionType.DEFEND)
@export var affect: Ruleset.Dice = Ruleset.Dice.D4: # Basic interaction with world die.
	set(value): set_value(Ruleset.ActionType.AFFECT, value)
	get(): return get_value(Ruleset.ActionType.AFFECT)
@export var resist: Ruleset.Dice = Ruleset.Dice.D4: # Basic shrug effects off die.
	set(value): set_value(Ruleset.ActionType.RESIST, value)
	get(): return get_value(Ruleset.ActionType.RESIST)

# Stored Values
var _values: Array[Ruleset.Dice] = []


func _init() -> void:
	_values.resize(Ruleset.ActionType.keys().size())


func set_value(knack: Ruleset.ActionType, dice_type: Ruleset.Dice) -> void:
	_values[knack] = dice_type


func get_value(knack: Ruleset.ActionType) -> Ruleset.Dice:
	return _values[knack]
