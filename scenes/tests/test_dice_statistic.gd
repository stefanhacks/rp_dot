extends Control

@export var bar_color := Color.WHITE
@export var dice_type: DiceTray.Dice = DiceTray.Dice.D4

var number_of_rolls = 0.0
var sum_of_rolls = 0.0
var max_bar_size = 260.0

@onready var texture_rect: TextureRect = $TextureRect
@onready var dice_label: Label = $DiceLabel
@onready var avg_label: Label = $AvgLabel


func _ready() -> void:
	dice_label.text = "D%s" % dice_type
	texture_rect.modulate = bar_color


func _process(_delta: float) -> void:
	number_of_rolls += 1
	sum_of_rolls += DiceTray.roll(dice_type)
	_update_bar()


func _update_bar() -> void:
	var average = sum_of_rolls / number_of_rolls
	texture_rect.size.y = max_bar_size * average / dice_type
	avg_label.text = "%2.2f" % average
