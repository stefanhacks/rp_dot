@tool
class_name StatsPlayable
extends Stats

# Static bonus for every action type.
@export var strike_bonus: int:
	set(value): set_value(Ruleset.Stat.STRIKE, value)
	get():return get_value(Ruleset.Stat.STRIKE)
@export var defend_bonus: int:
	set(value): set_value(Ruleset.Stat.DEFEND, value)
	get(): return get_value(Ruleset.Stat.DEFEND)
@export var affect_bonus: int:
	set(value): set_value(Ruleset.Stat.AFFECT, value)
	get(): return get_value(Ruleset.Stat.AFFECT)
@export var resist_bonus: int:
	set(value): set_value(Ruleset.Stat.RESIST, value)
	get(): return get_value(Ruleset.Stat.RESIST)
