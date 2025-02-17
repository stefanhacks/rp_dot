@tool
class_name StatsFoe
extends Stats

# Static bonus for every action type.
@export var to_strike_peril: int:
	set(value): set_value(Ruleset.Stat.STRIKE, value)
	get():return get_value(Ruleset.Stat.STRIKE)
@export var to_defend_peril: int:
	set(value): set_value(Ruleset.Stat.DEFEND, value)
	get(): return get_value(Ruleset.Stat.DEFEND)
@export var to_affect_peril: int:
	set(value): set_value(Ruleset.Stat.AFFECT, value)
	get(): return get_value(Ruleset.Stat.AFFECT)
@export var to_resist_peril: int:
	set(value): set_value(Ruleset.Stat.RESIST, value)
	get(): return get_value(Ruleset.Stat.RESIST)
