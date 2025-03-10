extends Control

@export var pure_test = false
@export var bar_color := Color.WHITE
@export var dice_type: Ruleset.Dice = Ruleset.Dice.D4

var _number_of_rolls = 0.0
var _sum_of_rolls = 0.0
var _sum_of_rolls_keep_high = 0.0
var _sum_of_rolls_keep_low = 0.0
var max_bar_size = 260.0

@onready var bar_1: TextureRect = $Bar1
@onready var bar_2: TextureRect = $Bar2
@onready var bar_3: TextureRect = $Bar3

@onready var dice_label: Label = $DiceLabel
@onready var avg_label: Label = $AvgLabel


func _ready() -> void:
	dice_label.text = 'D%s' % dice_type
	modulate = bar_color


func _physics_process(_delta: float) -> void:
	randomize()
	_update_bar()


func _update_bar() -> void:
	_number_of_rolls += 1.0
	
	if pure_test == true:
		_sum_of_rolls += randi_range(1, dice_type)
		_sum_of_rolls_keep_low += mini(randi_range(1, dice_type), randi_range(1, dice_type))
		_sum_of_rolls_keep_high += maxi(randi_range(1, dice_type), randi_range(1, dice_type))
	else:
		_sum_of_rolls += DiceTray.roll(dice_type).sum
		_sum_of_rolls_keep_low += DiceTray.roll(dice_type, 0, Ruleset.RollStyle.TWICE_KEEP_LOW).sum
		_sum_of_rolls_keep_high += DiceTray.roll(dice_type, 0, Ruleset.RollStyle.TWICE_KEEP_HIGH).sum
	
	var average = float(_sum_of_rolls) / _number_of_rolls
	avg_label.text = '%2.2f' % average
	
	bar_1.size.y = max_bar_size * (_sum_of_rolls_keep_low / _number_of_rolls) / float(dice_type)
	bar_2.size.y = max_bar_size * average / float(dice_type)
	bar_3.size.y = max_bar_size * (_sum_of_rolls_keep_high / _number_of_rolls) / float(dice_type)
