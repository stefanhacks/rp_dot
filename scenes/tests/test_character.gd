extends Node2D

@onready var character: Node = $Guy

func _ready() -> void:
	print(character.stats.max_health)
	print(character.proficiency.strike)
