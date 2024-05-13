@tool
extends Node
class_name OISState

var state_name : String
signal enter_state
signal exit_state
signal manage_behaviors(is_entering:bool)

func _ready():
	for i in get_children():
		if i is StateBehavior:
			enter_state.connect(i.on_enter_state)
			exit_state.connect(i.on_exit_state)

func _enter_tree():
	state_name = name

func _on_renamed():
	print(name + " renamed")
	var parent =  get_parent()
	if parent is StateManager:
		parent.settings.rename_state(state_name, name)
		state_name = name
