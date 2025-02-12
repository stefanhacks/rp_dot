extends Node

enum Dice { 
	D0 = 0,
	D2 = 2,
	D4 = 4,
	D6 = 6,
	D8 = 8,
	D10 = 10,
	D12 = 12,
}

enum RollStyle {
	ONCE,
	TWICE_KEEP_HIGH,
	TWICE_KEEP_LOW,
}

enum Stat {
	MAX_HEALTH,
	MOVE,
	RUN,
	DAMAGE,
	SURGE,
	STRIKE_BONUS,
	DEFEND_BONUS,
	AFFECT_BONUS,
	RESIST_BONUS,
}

enum ActionType {
	STRIKE,
	DEFEND,
	AFFECT,
	RESIST,
}

func action_to_bonus_stat(action: ActionType) -> Stat:
	match action:
		ActionType.STRIKE:
			return Stat.STRIKE_BONUS
		ActionType.DEFEND:
			return Stat.DEFEND_BONUS
		ActionType.AFFECT:
			return Stat.AFFECT_BONUS
		ActionType.RESIST:
			return Stat.RESIST_BONUS
		_: 
			push_error("Non valid action provided in action_to_bonus_stat call.")
			return Stat.MAX_HEALTH
