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
	set(value): set_value(Ruleset.Stat.STRIKE_BONUS, value)
	get():return get_value(Ruleset.Stat.STRIKE_BONUS)
@export var defend_bonus: int:
	set(value): set_value(Ruleset.Stat.DEFEND_BONUS, value)
	get(): return get_value(Ruleset.Stat.DEFEND_BONUS)
@export var affect_bonus: int:
	set(value): set_value(Ruleset.Stat.AFFECT_BONUS, value)
	get(): return get_value(Ruleset.Stat.AFFECT_BONUS)
@export var resist_bonus: int:
	set(value): set_value(Ruleset.Stat.RESIST_BONUS, value)
	get(): return get_value(Ruleset.Stat.RESIST_BONUS)

# Stored Values
var _values: Array[int] = []


func _init() -> void:
	_values.resize(Ruleset.Stat.keys().size() + Ruleset.ActionType.keys().size())


func set_value(stat: Ruleset.Stat, value: int) -> void:
	_values[stat] = value


func get_value(stat: Ruleset.Stat) -> int:
	return _values[stat]
