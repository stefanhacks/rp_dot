class_name CharacterPlayable
extends CharacterClickable

# Core Knacks
@export var knack = Knack.new()

# Inventory
@export var _trophies: Array[Modifier] = []


func roll_for(action: Ruleset.ActionType) -> DiceRoll:
	var dice = knack.get_value(action)
	var modifier = get_total_value(Ruleset.action_to_stat(action))
	
	return DiceTray.roll(dice, modifier)


func get_total_value(stat: Ruleset.Stat) -> int:
	var base = stats.get_value(stat)
	var _enchants_total = get_enchants_total(stat)
	var _trophies_total = get_trophies_total(stat)
	
	return base + _enchants_total + _trophies_total


func add_trophy(trophy: Modifier) -> void:
	_trophies.append(trophy)


func get_trophies_total(stat: Ruleset.Stat) -> int:
	return _get_mods_total(_trophies, stat)
	
