extends Node

enum Dice { 
	D4 = 4,
	D6 = 6,
	D8 = 8,
	D10 = 10,
	D12 = 12,
	D20 = 20,
}

enum RollStyle {
	ONCE,
	TWICE_KEEP_HIGH,
	TWICE_KEEP_LOW,
}

var explode = false


func roll(faces: Dice, modifier: int = 0, style = RollStyle.ONCE) -> DiceRoll:
	var diceroll = DiceRoll.new(faces, modifier, style)
	
	var roll_function: Callable
	match style:
		RollStyle.TWICE_KEEP_HIGH, RollStyle.TWICE_KEEP_LOW:
			roll_function = _roll_two_keep
		RollStyle.ONCE, _:
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


class DiceRoll:
	var faces: Dice = Dice.D4
	var modifier: int = 0
	var rolls: Array = []
	var style: RollStyle = RollStyle.ONCE
	
	var sum: int:
		get():
			return rolls.reduce(func(accum, roll): return accum + parse_roll(roll), 0)
	var total: int:
		get():
			return sum + modifier


	func _init(n_faces: Dice, sum_modifier: int, rollstyle: RollStyle) -> void:
		faces = n_faces
		modifier = sum_modifier
		style = rollstyle
	
	
	func parse_roll(roll) -> int:
		if typeof(roll) == TYPE_ARRAY:
			if style == RollStyle.TWICE_KEEP_HIGH:
				return maxi(roll[0], roll[1])
			else:
				return mini(roll[0], roll[1])
		else:
			return roll
	
