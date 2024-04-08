extends Node
class_name OISState

signal enter_state
signal exit_state

func _ready():
	for i in get_children():
		if i is StateBehavior:
			enter_state.connect(i.on_enter_state)
			exit_state.connect(i.on_exit_state)
