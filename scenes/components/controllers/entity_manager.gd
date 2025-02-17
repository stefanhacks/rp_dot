class_name EntityManager
extends Node

signal character_clicked
signal character_mouse_entered
signal character_mouse_exited
signal rogue_clicked
signal rogue_mouse_entered
signal rogue_mouse_exited
signal foe_clicked
signal foe_mouse_entered
signal foe_mouse_exited

var _characters_rogue: Array[CharacterRogue]
var _characters_foe: Array[CharacterFoe]
var _last_id_used = null


func get_next_free_id() -> int:
	var next_free_id = -(1 << 63) if _last_id_used == null else _last_id_used + 1
	_last_id_used = next_free_id
	return next_free_id


func add_rogue(node: CharacterRogue) -> void:
	node.id = get_next_free_id()
	node.clicked.connect(_on_rogue_mouse_click)
	node.mouse_entered.connect(_on_rogue_mouse_entered)
	node.mouse_exited.connect(_on_rogue_mouse_exited)
	node.health_reached_zero.connect(_on_rogue_health_reached_zero)
	
	_characters_rogue.push_back(node)


func add_foe(node: CharacterFoe) -> void:
	node.id = get_next_free_id()
	node.clicked.connect(_on_foe_mouse_click)
	node.mouse_entered.connect(_on_foe_mouse_entered)
	node.mouse_exited.connect(_on_foe_mouse_exited)
	node.health_reached_zero.connect(_on_foe_health_reached_zero)
	
	_characters_foe.push_back(node)


#region rogue Signals
func _on_rogue_health_reached_zero(node: CharacterRogue) -> void:
	print("rogue death. ", node)
	node.visible = false


func _on_rogue_mouse_click(node: CharacterRogue) -> void:
	rogue_clicked.emit(node)
	character_clicked.emit(node)


func _on_rogue_mouse_entered(node: CharacterRogue) -> void:
	rogue_mouse_entered.emit(node)
	character_mouse_entered.emit(node)


func _on_rogue_mouse_exited(node: CharacterRogue) -> void:
	rogue_mouse_exited.emit(node)
	character_mouse_exited.emit(node)


#endregion
#region foe Signals
func _on_foe_health_reached_zero(node: CharacterFoe) -> void:
	print("Foe death. ", node)
	node.visible = false


func _on_foe_mouse_click(node: CharacterFoe) -> void:
	foe_clicked.emit(node)
	character_clicked.emit(node)


func _on_foe_mouse_entered(node: CharacterFoe) -> void:
	foe_mouse_entered.emit(node)
	character_mouse_entered.emit(node)


func _on_foe_mouse_exited(node: CharacterFoe) -> void:
	foe_mouse_exited.emit(node)
	character_mouse_exited.emit(node)


#endregion
