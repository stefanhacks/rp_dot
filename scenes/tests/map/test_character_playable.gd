extends Node2D

@onready var rogue: Rogue = $Character

func _ready() -> void:
	_test_attack()
	print(' ')
	_test_health()
	print(' ')
	_test_trophy(Ruleset.Stat.STRIKE)
	_test_trophy(Ruleset.Stat.MAX_HEALTH)
	

func _test_attack() -> void:
	print ('# Testing Strike')
	var action = Ruleset.ActionType.STRIKE
	var stat = Ruleset.action_to_stat(action)
	rogue.stats.set_value(stat, -1)
	rogue.knack.strike = Ruleset.Dice.D4
	
	var enchant = ModifierTemporary.new()
	enchant.set_value(stat, 2)
	rogue.add_enchant(enchant)
	
	var trophy = Modifier.new()
	trophy.set_value(stat, 5)
	rogue.add_trophy(trophy)
	
	var roll = rogue.roll_for(action)
	
	print('Strike Knack: D', rogue.knack.get_value(action))
	print('Strike Bonus: ', rogue.stats.get_value(stat))
	print('Strike Enchants: ', rogue.get_enchants_total(stat))
	print('Strike Trophies: ', rogue.get_trophies_total(stat))
	
	print('-')
	
	print('Strike Roll: ', roll.rolls[0])
	print('Strike Stat: ', rogue.get_total_value(stat))
	print('Strike Total: ', roll.total)
	assert(roll.total == rogue.get_total_value(stat) + roll.rolls[0])


func _test_health() -> void:
	print ('# Testing Health')
	_assert_alive(false)
	rogue.stats.max_health = 10
	var max_health = rogue.stats.get_value(Ruleset.Stat.MAX_HEALTH)
	assert(rogue.stats.max_health == max_health)
	rogue.heal()
	_assert_alive(true)
	rogue.take_damage(1)
	_assert_alive(true)
	rogue.take_damage(max_health * 3)
	_assert_alive(false)
	rogue.heal(1)
	_assert_alive(true)


func _assert_alive(expected_value: bool) -> void:
	print('Is alive.' if rogue.is_alive else 'Is dead.')
	assert(rogue.is_alive == expected_value)


func _on_rogue_health_reached_zero() -> void:
	print('0 HP reached.')


func _test_trophy(stat: Ruleset.Stat) -> void:
	print ('# Testing Trophy for Index %s' % stat)
	
	var value = rogue.stats.get_value(stat)
	var enchants_mods = rogue.get_enchants_total(stat)
	var trophies_mods = rogue.get_trophies_total(stat)
	var full_value = rogue.get_total_value(stat)
	
	print(full_value, ' = ', value, ' + ', enchants_mods, ' + ', trophies_mods)
	assert(full_value ==  value + enchants_mods + trophies_mods)
	
