class_name EntityController
extends Node

signal entity_clicked
signal entity_mouse_entered
signal entity_mouse_exited

var characters_playable: Array[CharacterPlayable]
var characters_monster: Array[CharacterMonster]


func add_playable(node: CharacterPlayable) -> void:
	characters_playable.push_back(node)
	_connect_signals(node)


func add_monster(node: CharacterMonster) -> void:
	characters_monster.push_back(node)
	_connect_signals(node)


func _connect_signals(node: CharacterClickable) -> void:
	node.clicked.connect(_on_character_mouse_click)
	node.mouse_entered.connect(_on_character_mouse_entered)
	node.mouse_exited.connect(_on_character_mouse_exited)


func _on_character_mouse_click(node: Node) -> void:
	entity_clicked.emit(node)


func _on_character_mouse_entered(node: Node) -> void:
	entity_mouse_entered.emit(node)


func _on_character_mouse_exited(node: Node) -> void:
	entity_mouse_exited.emit(node)
