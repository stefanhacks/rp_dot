@tool
class_name StatsMonster
extends Stats

# Static bonus for every action type.
@export var strike_peril: int:
	set(value): set_value(Ruleset.Stat.STRIKE, value)
	get():return get_value(Ruleset.Stat.STRIKE)
@export var defend_peril: int:
	set(value): set_value(Ruleset.Stat.DEFEND, value)
	get(): return get_value(Ruleset.Stat.DEFEND)
@export var affect_peril: int:
	set(value): set_value(Ruleset.Stat.AFFECT, value)
	get(): return get_value(Ruleset.Stat.AFFECT)
@export var resist_peril: int:
	set(value): set_value(Ruleset.Stat.RESIST, value)
	get(): return get_value(Ruleset.Stat.RESIST)
