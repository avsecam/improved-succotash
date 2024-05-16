@tool
extends Resource
class_name StateManagerSettings

@export var state_behavior_settings = {}
@export var behavior_dict = {}

func get_value(state_name: String, behavior_name: String):
	if has_state(state_name) && state_behavior_settings[state_name].has(behavior_name):
		return state_behavior_settings[state_name][behavior_name]
	else:
		return null #should it be false?

func change_value(state_name: String, behavior_name: String, value : bool):
	if has_state(state_name) && has_behavior(behavior_name):
		print("changing value")
		state_behavior_settings[state_name][behavior_name] = value

func add_state(state_name : String):
	print("settings: add state")
	state_behavior_settings[state_name] = behavior_dict.duplicate()

func remove_state(state_name : String):
	print("settings: rm state")
	if Engine.is_editor_hint():
		print("in editor rm state")
	state_behavior_settings.erase(state_name)

func has_state(state_name : String):
	return state_behavior_settings.has(state_name)

func rename_state(old_name : String, new_name : String):
	print(old_name + " --> " + new_name)
	if has_state(old_name) && old_name != new_name:
		state_behavior_settings[new_name] = state_behavior_settings[old_name]
		state_behavior_settings.erase(old_name)

func add_behavior(behavior_name : String):
	print("settings: add behavior")
	behavior_dict[behavior_name] = false
	for state in state_behavior_settings:
		state_behavior_settings[state][behavior_name] = false

func remove_behavior(behavior_name : String):
	print("settings: rm behavior")
	behavior_dict.erase(behavior_name)
	for state in state_behavior_settings:
		state_behavior_settings[state].erase(behavior_name)

func has_behavior(behavior_name : String):
	return behavior_dict.has(behavior_name)

func rename_behavior(old_name : String, new_name : String):
	print(old_name + " --> " + new_name)
	if has_behavior(old_name) && old_name != new_name:
		# fix behavior list template for new states
		behavior_dict.erase(old_name)
		behavior_dict[old_name] = false
		
		# change behavior name for previous states
		for state in state_behavior_settings:
			state_behavior_settings[state][new_name] = state_behavior_settings[state][old_name]
			state_behavior_settings[state].erase(old_name)

# example
#settings = {
	#state1 : {
		#behavior1 : false,
		#behavior2 : false,
	#},
	#state2 : {
		#behavior1 : true,
		#behavior2 : false,
	#},
	#state3 : {
		#behavior1 : true,
		#behavior2 : true,
	#}
#}
