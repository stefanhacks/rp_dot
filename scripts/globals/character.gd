class_name Character
extends Node

signal health_reached_zero

# Core Stats
@export var stats = Stats.new()
@export var knack = Knack.new()

# Mods
@export var _enchants: Array[TemporaryModifier] = []
@export var _trophies: Array[Modifier] = []

# Vars
var current_health: int
var is_alive: bool: 
	get(): return current_health > 0


#region Basic Stats
func roll_for(action: Ruleset.ActionType) -> DiceRoll:
	var dice = knack.get_value(action)
	var modifier = get_total_value(Ruleset.action_to_bonus_stat(action))
	
	return DiceTray.roll(dice, modifier)


func heal(amount: int = stats.get_value(Ruleset.Stat.MAX_HEALTH)) -> void:
	if amount > 0:
		current_health = min(stats.get_value(Ruleset.Stat.MAX_HEALTH), current_health + amount)


func take_damage(amount: int) -> void:
	current_health = max(0, current_health - amount)
	if current_health == 0:
		health_reached_zero.emit()


func get_total_value(stat: Ruleset.Stat) -> int:
	var base = stats.get_value(stat)
	var _enchants_total = get_enchants_total(stat)
	var _trophies_total = get_trophies_total(stat)
	
	return base + _enchants_total + _trophies_total


#endregion
#region Modifiers
func _get_mods(source_array: Array, stat: Ruleset.Stat) -> Array[Modifier]:
	var is_mod_relevant = func (mod: Modifier):
		return mod.get_value(stat) != 0

	return source_array.filter(is_mod_relevant)


func _get_mods_total(source_array: Array, stat: Ruleset.Stat) -> int:
	var sum_relevant_mod = func (accum: int, mod: Modifier): 
		return accum + mod.get_value(stat)
	
	return source_array.reduce(sum_relevant_mod, 0)


func add_enchant(enchant: TemporaryModifier) -> void:
	_enchants.append(enchant)


func add_trophy(trophy: Modifier) -> void:
	_trophies.append(trophy)


func get_enchants_total(stat: Ruleset.Stat) -> int:
	return _get_mods_total(_enchants as Array[Modifier], stat)


func get_trophies_total(stat: Ruleset.Stat) -> int:
	return _get_mods_total(_trophies, stat)


#endregion
