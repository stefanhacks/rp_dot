@tool
class_name PathBreadcrumb
extends Sprite2D

@export var breadcrumb_sprite: Texture2D
@export var target_sprite: Texture2D
@export var is_target: bool = false:
	set(as_target):
		is_target = as_target
		if is_target == true:
			texture = target_sprite
		else:
			texture = breadcrumb_sprite
