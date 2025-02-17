@tool
class_name Breadcrumb
extends Sprite2D

@export var kind: Indication = Indication.WALK:
	set(as_indication):
		kind = as_indication
		frame = as_indication

enum Indication {
	WALK,
	WALK_END,
	RUN,
	RUN_END,
	TARGET,
	MARK,
}
