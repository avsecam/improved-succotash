@tool
extends Node3D
class_name StateManager

@export var init_settings : bool = false

@export var receiver_group : String = ""
@export var current_state : OISState
@export var debug : bool = true

@export var settings : StateManagerSettings
var in_authoring_tool : bool = false

var receiver_object
@onready var actor = get_parent()

func _ready():
	print("Yo fellas")
	if !in_authoring_tool:
		if settings == null:
			print("State Manager Error: No state manager settings")
			push_error("State Manager Error: No state manager settings")
		else:
			if debug:
				print(settings.state_behavior_settings)
			
			
			#Connect state signals to behaviors as indicate in settings resoource
			for state in settings.state_behavior_settings:
				for behavior in settings.behavior_dict:
					if settings.get_value(state, behavior):
						var s = get_node_or_null(state)
						var b = get_node_or_null(behavior)
						if s != null && b!= null:
							s.manage_behavior.connect(b.manage_signal)
		await actor.ready
		#Set initial state
		set_state(current_state)

func set_state(state : OISState):
	if (current_state != null):
		#current_state.exit_state.emit()
		current_state.manage_behavior.emit(false)
	else:
		print("State Manager Error: Set current state of object (initial state)")
		push_error("State Manager Error: Set current state of object (initial state)")
	if debug:
		print(actor.name + ": " + current_state.name + " -> " + state.name)
	current_state = state
	#current_state.enter_state.emit()
	current_state.manage_behavior.emit(true)

func _process(delta):
	if Engine.is_editor_hint():
		if init_settings:
			settings = StateManagerSettings.new()
			for child in get_children():
				if child is OISState:
					settings.add_state(child.name)
				elif child is StateBehavior:
					settings.add_behavior(child.name)
			init_settings = false

#func add_behavior(behavior : StateBehavior):
	#add_child(behavior)
	#behavior.owner = self
	#settings.add_behavior(behavior.name)
