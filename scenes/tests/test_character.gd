extends Node2D

@onready var character: Character = $Character

func _ready() -> void:
	_test_basics()
	print(" ")
	_test_trophy(Ruleset.Stat.DAMAGE)
	_test_trophy(Ruleset.Stat.MAX_HEALTH)
	_test_trophy(Ruleset.Stat.SURGE)


func _test_basics() -> void:
	print ("# Testing Basic Stats")
	var max_health = character.stats.get_value(Ruleset.Stat.MAX_HEALTH)
	print("Max HP: ", max_health)
	
	var roll = character.roll_for(Ruleset.ActionType.STRIKE);
	print("Strike Knack: D", character.knack.get_value(Ruleset.ActionType.STRIKE))
	print("Strike Bonus: ", character.stats.get_bonus(Ruleset.ActionType.STRIKE))
	print("Strike Mod: ", character.mods.get_bonus(Ruleset.ActionType.STRIKE))
	print("Strike Roll: ", roll.rolls[0])
	print("Strike Total: ", roll.total)
	
	_assert_alive(false)
	character.heal()
	_assert_alive(true)
	character.take_damage(1)
	_assert_alive(true)
	character.take_damage(max_health * 3)
	_assert_alive(false)
	character.heal(1)
	_assert_alive(true)


func _assert_alive(expected_value: bool) -> void:
	print("Is alive." if character.is_alive else "Is dead.")
	assert(character.is_alive == expected_value)


func _on_character_health_reached_zero() -> void:
	print("0 HP reached.")


func _test_trophy(stat: Ruleset.Stat) -> void:
	print ("# Testing Trophy for Index %s" % stat)
	
	var damage = character.stats.get_value(stat)
	var damage_mod = character.mods.get_value(stat)
	var total_value = character.get_trophies_total(stat)
	var full_value = character.get_modified_value(stat)
	
	print(full_value, " = ", damage, ' + ', damage_mod, " + ", total_value)
	assert(full_value ==  damage + damage_mod + total_value)
	
