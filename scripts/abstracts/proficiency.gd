@tool
class_name Proficiency
extends Resource

# Accessors
@export var strike: Ruleset.Dice:
	set(value):
		_values[Ruleset.ActionType.STRIKE] = value
	get():
		return _values[Ruleset.ActionType.STRIKE]
@export var defend: Ruleset.Dice:
	set(value):
		_values[Ruleset.ActionType.DEFEND] = value
	get():
		return _values[Ruleset.ActionType.DEFEND]
@export var affect: Ruleset.Dice:
	set(value):
		_values[Ruleset.ActionType.AFFECT] = value
	get():
		return _values[Ruleset.ActionType.AFFECT]
@export var resist: Ruleset.Dice:
	set(value):
		_values[Ruleset.ActionType.RESIST] = value
	get():
		return _values[Ruleset.ActionType.RESIST]

# Core Stats
var _values: Array[int] = []

func _init() -> void:
	_values.resize(Ruleset.ActionType.keys().size())
