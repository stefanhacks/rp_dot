@tool
class_name Stats
extends Resource

# Accessors
@export var max_health: int: # Value current hp starts as.
	set(value): set_value(Ruleset.Stat.MAX_HEALTH, value)
	get(): return get_value(Ruleset.Stat.MAX_HEALTH)

@export var surge: int: # Highest value goes first.
	set(value): set_value(Ruleset.Stat.SURGE, value)
	get(): return get_value(Ruleset.Stat.SURGE)
@export var move: int: # Available movement distance.
	set(value): set_value(Ruleset.Stat.MOVE, value)
	get(): return get_value(Ruleset.Stat.MOVE)
@export var run: int: # Extra move if not striking.
	set(value): set_value(Ruleset.Stat.RUN, value)
	get(): return get_value(Ruleset.Stat.RUN)
@export var damage: int: # Base damage dealt on a strike.
	set(value): set_value(Ruleset.Stat.DAMAGE, value)
	get(): return get_value(Ruleset.Stat.DAMAGE)

# Static bonus for every action type.
@export var strike_bonus: int:
	set(value): set_bonus(Ruleset.ActionType.STRIKE, value)
	get():return get_bonus(Ruleset.ActionType.STRIKE)
@export var defend_bonus: int:
	set(value): set_bonus(Ruleset.ActionType.DEFEND, value)
	get(): return get_bonus(Ruleset.ActionType.DEFEND)
@export var affect_bonus: int:
	set(value): set_bonus(Ruleset.ActionType.AFFECT, value)
	get(): return get_bonus(Ruleset.ActionType.AFFECT)
@export var resist_bonus: int:
	set(value): set_bonus(Ruleset.ActionType.RESIST, value)
	get(): return get_bonus(Ruleset.ActionType.RESIST)

# Stored Values
var _values: Array[int] = []


func _init() -> void:
	_values.resize(Ruleset.Stat.keys().size() + Ruleset.ActionType.keys().size())


func set_value(stat: Ruleset.Stat, value: int) -> void:
	_values[stat] = value


func get_value(stat: Ruleset.Stat) -> int:
	return _values[stat]


func set_bonus(action: Ruleset.ActionType, value: int) -> void:
	_values[action + Ruleset.Stat.keys().size()] = value


func get_bonus(action: Ruleset.ActionType) -> int:
	return _values[action + Ruleset.Stat.keys().size()]
