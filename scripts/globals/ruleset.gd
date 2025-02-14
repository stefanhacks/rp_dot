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
	WALK,
	RUN,
	DAMAGE,
	SURGE,
	STRIKE,
	DEFEND,
	AFFECT,
	RESIST,
}

enum ActionType {
	STRIKE,
	DEFEND,
	AFFECT,
	RESIST,
}

func action_to_stat(action: ActionType) -> Stat:
	match action:
		ActionType.STRIKE:
			return Stat.STRIKE
		ActionType.DEFEND:
			return Stat.DEFEND
		ActionType.AFFECT:
			return Stat.AFFECT
		ActionType.RESIST:
			return Stat.RESIST
		_: 
			push_error("Non valid action provided in action_to_stat call.")
			return Stat.MAX_HEALTH
