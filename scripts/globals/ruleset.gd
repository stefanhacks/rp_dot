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

enum Stat {
	MAX_HEALTH,
	MOVE,
	RUN,
	DAMAGE,
	SURGE,
}

enum ActionType {
	STRIKE,
	DEFEND,
	AFFECT,
	RESIST,
}
