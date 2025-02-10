@tool
class_name Stats
extends Resource

# Accessors
@export var max_health: int:
	set(value):
		_values[Ruleset.Stat.MAX_HEALTH] = value
	get():
		return _values[Ruleset.Stat.MAX_HEALTH]

@export var surge: int:
	set(value):
		_values[Ruleset.Stat.SURGE] = value
	get():
		return _values[Ruleset.Stat.SURGE]
@export var move: int:
	set(value):
		_values[Ruleset.Stat.MOVE] = value
	get():
		return _values[Ruleset.Stat.MOVE]
@export var run: int:
	set(value):
		_values[Ruleset.Stat.RUN] = value
	get():
		return _values[Ruleset.Stat.RUN]
@export var damage: int:
	set(value):
		_values[Ruleset.Stat.DAMAGE] = value
	get():
		return _values[Ruleset.Stat.DAMAGE]

@export var strike_bonus: int:
	set(value):
		_values[Ruleset.Stat.STRIKE_BONUS] = value
	get():
		return _values[Ruleset.Stat.STRIKE_BONUS]
@export var defend_bonus: int:
	set(value):
		_values[Ruleset.Stat.DEFEND_BONUS] = value
	get():
		return _values[Ruleset.Stat.DEFEND_BONUS]
@export var affect_bonus: int:
	set(value):
		_values[Ruleset.Stat.AFFECT_BONUS] = value
	get():
		return _values[Ruleset.Stat.AFFECT_BONUS]
@export var resist_bonus: int:
	set(value):
		_values[Ruleset.Stat.RESIST_BONUS] = value
	get():
		return _values[Ruleset.Stat.RESIST_BONUS]

# Core Stats
var _values: Array[int] = []

func _init() -> void:
	_values.resize(Ruleset.Stat.keys().size())
