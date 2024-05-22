extends SplitContainer

var raycast_behavior = preload("res://src/ois/states/control_raycast.tscn")
var snap_behavior = preload("res://src/ois/states/snap_objects.tscn")
var interact_behavior = preload("res://src/ois/states/interact_receiver.tscn")

var state_behavior_cb = preload("res://src/ois/authoring_tool/state_behavior_cb.tscn")

var raycast_settings = preload("res://src/ois/authoring_tool/behavior_settings/raycast_settings.tscn")
var snap_settings = preload("res://src/ois/authoring_tool/behavior_settings/snap_settings.tscn")
var interact_settings = preload("res://src/ois/authoring_tool/behavior_settings/interact_settings.tscn")

@onready var behavior_container = $BoxContainer/ScrollContainer/BehaviorContainer
@onready var state_behavior_settings_container = $SplitContainer/Panel/ScrollContainer/StateBehaviorSettingsContainer
@onready var new_behavior_selector = $BoxContainer/OptionButton

var editable_obj
var sm : StateManager
var sm_settings : StateManagerSettings

func _ready():
	new_behavior_selector.add_item("Raycast")
	new_behavior_selector.add_item("Snap")
	new_behavior_selector.add_item("Interact")
	new_behavior_selector.selected = -1

func set_up_actor_settings(obj):
	clear_actor_settings()
	editable_obj = obj
	sm = obj.get_node_or_null("StateManager")
	if sm is StateManager:
		if sm.settings == null:
			sm_settings = StateManagerSettings.new()
			for child in sm.get_children():
				if child is OISState:
					sm_settings.add_state(child.name)
				elif child is StateBehavior:
					sm_settings.add_behavior(child.name)
		else:
			sm_settings = sm.settings
		set_up_grid()

func clear_actor_settings():
	for child in state_behavior_settings_container.get_children():
		child.queue_free()
	for child in behavior_container.get_children():
		child.queue_free()

func set_up_grid():
	var behavior_labels_container = VBoxContainer.new()
	var label_blank = Label.new()
	label_blank.text = ""
	behavior_labels_container.add_child(label_blank)
	for behavior in sm_settings.behavior_dict:
		var label = Label.new()
		label.text = behavior
		behavior_labels_container.add_child(label)
		
		var behavior_node = sm.get_node_or_null(behavior)
		if behavior_node != null:
			add_behavior_settings(behavior_node)
		else:
			print("Error: could not load behavior '" + behavior + "'")
	state_behavior_settings_container.add_child(behavior_labels_container)
	
	for state in sm_settings.state_behavior_settings:
		var box_cont = VBoxContainer.new()
		var label = Label.new()
		label.text = state
		box_cont.add_child(label)
		for behavior in sm_settings.state_behavior_settings[state]:
			var cb = state_behavior_cb.instantiate()
			cb.set_values(state, behavior)
			#cb.name = state + "." + behavior
			cb.button_pressed = sm_settings.get_value(state, behavior)
			box_cont.add_child(cb)
			
			# connect signals so state manager settings update according to checkbox 
			cb.change_value.connect(sm_settings.change_value)
		state_behavior_settings_container.add_child(box_cont)

func _on_btn_add_behavior_pressed():
	var behavior
	match new_behavior_selector.get_selected_id():
		0: #raycast
			add_behavior_settings(create_bahavior("Raycast"))
		1: #snap
			add_behavior_settings(create_bahavior("Snap"))
		2: #interact
			add_behavior_settings(create_bahavior("Interact"))
	new_behavior_selector.selected = -1

# Instantiates corresponding StateBehavior Scene
# Adds to object and updates object's state manager settings
func create_bahavior(behavior_type : String):
	var behavior
	
	match behavior_type:
		"Raycast":
			behavior = raycast_behavior.instantiate()
		"Snap":
			behavior = snap_behavior.instantiate()
		"Interact":
			behavior = interact_behavior.instantiate()

	sm.add_child(behavior)
	sm_settings.add_behavior(behavior.name)
	behavior.owner = editable_obj
	return behavior

# Instantiates corresponding StateBehaviorSettings Scene
func add_behavior_settings(behavior_node : StateBehavior):
	var setting_node : StateBehaviorSettings
	if behavior_node is SBRaycast:
		setting_node = raycast_settings.instantiate()
	elif behavior_node is SBSnap:
		setting_node = snap_settings.instantiate()
	elif behavior_node is SBInteract:
		setting_node = interact_settings.instantiate()
	
	behavior_container.add_child(setting_node)
	setting_node.set_behavior_node(behavior_node)
	#  connect signals so state behavior updates according to changes to behavior settings 

func _on_btn_check_settings_pressed():
	print(sm_settings.behavior_dict)
