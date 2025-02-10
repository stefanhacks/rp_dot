class_name Character
extends Node

signal health_reached_zero

# Core Stats
@export var stats = Stats.new()
@export var proficiency = Proficiency.new()

# Mods
@export var mods = Stats.new()
@export var trophies: Array[Trophy] = []

# Vars
var current_health: int
var is_alive: bool: 
	get(): return current_health > 0


func heal(amount: int = 0) -> void:
	current_health = min(stats.base_values[Ruleset.Stat.MAX_HEALTH], current_health + amount)


func take_damage(amount: int) -> void:
	current_health = max(0, current_health - amount)
	if current_health == 0:
		health_reached_zero.emit()
