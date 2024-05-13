@tool
extends Node3D
class_name StateManager

@export var receiver_group : String = ""
@export var current_state : OISState
@export var debug : bool = true

var receiver_object
@onready var actor = get_parent()

@export var settings : StateManagerSettings
var behaviors = []
var states = []

func _ready():
	await actor.ready
	#set_state(current_state)

func set_state(state : OISState):
	if (current_state != null):
		current_state.exit_state.emit()
	else:
		print("State Manager Error: Set current state of object (initial state)")
		push_error("State Manager Error: Set current state of object (initial state)")
	#if debug:
		#print(actor.name + ": " + current_state.name + " -> " + state.name)
	current_state = state
	current_state.enter_state.emit()

# === handles UI ===
func _on_tree_entered():
	print(name + " added to tree")
	if settings == null:
		print(name + " Created new manager settings")
		settings = StateManagerSettings.new()
	print(settings.settings)

func _on_child_entered_tree(node):
	print(name + " add child")
	if node is OISState:
		states.append(node)
		if(!settings.has_state(node.name)):
			settings.add_state(node.name)
	if node is StateBehavior:
		behaviors.append(node) 
		if(!settings.has_behavior(node.name)):
			settings.add_behavior(node.name)

func _on_child_exiting_tree(node):
	print(name + " rm child")
	if node is OISState:
		states.erase(node)
		settings.remove_state(node.name)
	if node is StateBehavior:
		behaviors.erase(node) 
		# settings.remove_behavior(node.name)
