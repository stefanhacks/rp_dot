extends Node

enum Dice { 
	D4 = 4,
	D6 = 6,
	D8 = 8,
	D10 = 10,
	D12 = 12,
	D20 = 20,
}


func roll(dice: Dice, modifier: int = 0) -> int:
	return randi_range(1, dice) + modifier


func roll_two_keep_high(dice: Dice, modifier: int = 0) -> int:
	return maxi(randi_range(1, dice), randi_range(1, dice)) + modifier


func roll_two_keep_low(dice: Dice, modifier: int = 0) -> int:
	return mini(randi_range(1, dice), randi_range(1, dice)) + modifier
