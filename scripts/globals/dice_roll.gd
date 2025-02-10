class_name DiceRoll

var faces: Ruleset.Dice = Ruleset.Dice.D4
var modifier: int = 0
var rolls: Array = []
var style: Ruleset.RollStyle = Ruleset.RollStyle.ONCE

var sum: int:
	get(): return rolls.reduce(func(accum, roll): return accum + parse_roll(roll), 0)
var total: int:
	get(): return sum + modifier


func _init(n_faces: Ruleset.Dice, sum_modifier: int, rollstyle: Ruleset.RollStyle) -> void:
	faces = n_faces
	modifier = sum_modifier
	style = rollstyle


func parse_roll(roll) -> int:
	if typeof(roll) == TYPE_ARRAY:
		if style == Ruleset.RollStyle.TWICE_KEEP_HIGH:
			return maxi(roll[0], roll[1])
		else:
			return mini(roll[0], roll[1])
	else:
		return roll
