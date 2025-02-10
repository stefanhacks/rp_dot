class_name Character
extends Node

signal health_reached_zero

# Core Stats
@export var stats = Stats.new()
@export var knack = Knack.new()

# Mods
@export var mods = Stats.new()
@export var trophies: Array[Trophy] = []

# Vars
var current_health: int
var is_alive: bool: 
	get(): return current_health > 0


func heal(amount: int = stats.get_value(Ruleset.Stat.MAX_HEALTH)) -> void:
	if amount > 0:
		current_health = min(stats.get_value(Ruleset.Stat.MAX_HEALTH), current_health + amount)


func take_damage(amount: int) -> void:
	current_health = max(0, current_health - amount)
	if current_health == 0:
		health_reached_zero.emit()


func roll_for(action: Ruleset.ActionType) -> DiceRoll:
	var dice = knack.get_value(action)
	var bonus = stats.get_bonus(action)
	var modifier = mods.get_bonus(action)
	return DiceTray.roll(dice, bonus + modifier)


func get_modified_value(stat: Ruleset.Stat) -> int:
	var base = stats.get_value(stat)
	var mod = mods.get_value(stat)
	var trophy_total = get_trophies_total(stat)
	return base + mod + trophy_total


func get_trophies(stat: Ruleset.Stat) -> Array[Trophy]:
	return trophies.filter(func (trophy: Trophy): return trophy.modifies == stat)


func get_trophies_total(stat: Ruleset.Stat) -> int:
	return get_trophies(stat).reduce(func(accum, trophy): return accum + trophy.value, 0)
