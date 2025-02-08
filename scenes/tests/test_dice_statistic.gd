extends Control

@export var bar_color := Color.WHITE
@export var dice_type: DiceTray.Dice = DiceTray.Dice.D4

var number_of_rolls = 0.0
var sum_of_rolls = 0.0
var sum_of_rolls_keep_high = 0.0
var sum_of_rolls_keep_low = 0.0
var max_bar_size = 260.0

@onready var bar_1: TextureRect = $Bar1
@onready var bar_2: TextureRect = $Bar2
@onready var bar_3: TextureRect = $Bar3

@onready var dice_label: Label = $DiceLabel
@onready var avg_label: Label = $AvgLabel


func _ready() -> void:
	dice_label.text = "D%s" % dice_type
	modulate = bar_color


func _physics_process(delta: float) -> void:
	_update_bar()


func _update_bar() -> void:
	number_of_rolls += 1
	sum_of_rolls += DiceTray.roll(dice_type)
	sum_of_rolls_keep_low += DiceTray.roll_two_keep_low(dice_type)
	sum_of_rolls_keep_high += DiceTray.roll_two_keep_high(dice_type)
	
	var average = sum_of_rolls / number_of_rolls
	avg_label.text = "%2.2f" % average
	
	bar_1.size.y = max_bar_size * (sum_of_rolls_keep_low / number_of_rolls) / dice_type
	bar_2.size.y = max_bar_size * average / dice_type
	bar_3.size.y = max_bar_size * (sum_of_rolls_keep_high / number_of_rolls) / dice_type
