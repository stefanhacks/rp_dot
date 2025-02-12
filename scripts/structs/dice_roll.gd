class_name DiceRoll

var faces: Ruleset.Dice
var modifier: int
var style: Ruleset.RollStyle

var rolls: Array = []

var sum: int:
	get(): return rolls.reduce(func(accum, roll): return accum + parse_roll(roll), 0)
var total: int:
	get(): return sum + modifier


func _init(n_faces: Ruleset.Dice = Ruleset.Dice.D4, sum_modifier: int = 0, rollstyle: Ruleset.RollStyle = Ruleset.RollStyle.ONCE) -> void:
	faces = n_faces
	modifier = sum_modifier
	style = rollstyle


func add_roll(value: int) -> void:
	rolls.append(value)


func add_roll_pair(values: Array[int]) -> void:
	rolls.append(values)


func parse_roll(roll) -> int:
	if typeof(roll) == TYPE_ARRAY:
		if style == Ruleset.RollStyle.TWICE_KEEP_HIGH:
			return maxi(roll[0], roll[1])
		else:
			return mini(roll[0], roll[1])
	else:
		return roll
