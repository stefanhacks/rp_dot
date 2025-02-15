class_name Character
extends Node2D

signal health_reached_zero

# Core Stats
@export var stats: Stats

# Mods
@export var _enchants: Array[ModifierTemporary]

# Vars
var current_health: int
var is_alive: bool: 
	get(): return current_health > 0


#region Basic Stats
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
	
	return base + _enchants_total


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


func add_enchant(enchant: ModifierTemporary) -> void:
	_enchants.append(enchant)



func get_enchants_total(stat: Ruleset.Stat) -> int:
	return _get_mods_total(_enchants as Array[Modifier], stat)


#endregion
