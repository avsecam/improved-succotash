@tool
extends Node
class_name StateBehavior

var behavior_name : String

func on_enter_state():
	pass

func on_exit_state():
	pass

func _enter_tree():
	behavior_name = name

func manage_signal(is_entering):
	if is_entering:
		on_enter_state()
	else:
		on_exit_state()

func _on_renamed():
	print(name + " renamed")
	var parent =  get_parent()
	if parent is StateManager:
		parent.settings.rename_behavior(behavior_name, name)
		behavior_name = name
