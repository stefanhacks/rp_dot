extends Control

enum ColorScheme { MOVE, STRIKE, BREATHE }

@export var _border: ColorRect
@export var _background: ColorRect
@export var _title: Label
@export var _description: Label

@export var current_scheme: ColorScheme


func _ready() -> void:
	match current_scheme:
		ColorScheme.MOVE: _setup_messages('MOVE')
		ColorScheme.STRIKE: _setup_messages('STRIKE')
		ColorScheme.BREATHE: _setup_messages('BREATHE')


func _setup_messages(key: String) -> void:
	_title.text = Messages.Card[key]['TITLE']
	_description.text = Messages.Card[key]['DESCRIPTION']
	_background.color = Messages.Themes[key]['BG']
	_border.color = Messages.Themes[key]['BORDER']
