extends Node


func roll(faces: Ruleset.Dice, modifier: int = 0, style = Ruleset.RollStyle.ONCE, explode = false) -> DiceRoll:
	var diceroll = DiceRoll.new(faces, modifier, style)
	
	var roll_function: Callable
	match style:
		Ruleset.RollStyle.TWICE_KEEP_HIGH, Ruleset.RollStyle.TWICE_KEEP_LOW:
			roll_function = _roll_two_keep
		Ruleset.RollStyle.ONCE, _:
			roll_function = _roll_once
	
	if explode == false:
		return roll_function.call(diceroll)
	else:
		return _explode(diceroll, roll_function)


func _roll_once(diceroll: DiceRoll) -> DiceRoll:
	var value = randi_range(1, diceroll.faces)
	diceroll.rolls.append(value)
	return diceroll


func _roll_two_keep(diceroll: DiceRoll) -> DiceRoll:
	var values = [randi_range(1, diceroll.faces), randi_range(1, diceroll.faces)]
	diceroll.rolls.append(values)
	return diceroll


func _explode(diceroll: DiceRoll, roll_function: Callable) -> DiceRoll:
	var value = null
	while value == null or value == diceroll.faces:
		roll_function.call(diceroll)
		value = diceroll.parse_roll(diceroll.rolls[-1])
	
	return diceroll
