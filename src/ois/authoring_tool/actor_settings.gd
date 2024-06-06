extends SplitContainer

signal edited_object(new_component)

var raycast_behavior = preload("res://src/ois/states/control_raycast.tscn")
var snap_behavior = preload("res://src/ois/states/snap_objects.tscn")
var interact_behavior = preload("res://src/ois/states/interact_receiver.tscn")

var state_behavior_cb = preload("res://src/ois/authoring_tool/state_behavior_cb.tscn")

var component_settings_scn = preload("res://src/ois/authoring_tool/component_settings.tscn")

@onready var behavior_container = $BoxContainer/ScrollContainer/BehaviorContainer
@onready var state_behavior_settings_container = $SplitContainer/Panel/ScrollContainer/StateBehaviorSettingsContainer
@onready var new_behavior_selector = $BoxContainer/OptionButton

var editable_obj
var sm : StateManager
var sm_settings : StateManagerSettings

func _ready():
	new_behavior_selector.add_item("Raycast")
	new_behavior_selector.set_item_metadata(0, raycast_behavior)
	new_behavior_selector.add_item("Snap")
	new_behavior_selector.set_item_metadata(1, snap_behavior)
	new_behavior_selector.add_item("Interact")
	new_behavior_selector.set_item_metadata(2, interact_behavior)
	new_behavior_selector.selected = -1

func set_up_actor_settings(obj):
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
	clear_actor_settings()
	set_up_behavior_container()
	set_up_state_behavior_settings_container()

func set_up_state_behavior_settings_container():
	# Clear Container
	for child in state_behavior_settings_container.get_children():
		child.queue_free()
	
	# Setup behavior labels
	var behavior_labels_container = VBoxContainer.new()
	var label_blank = Label.new()
	label_blank.text = ""
	behavior_labels_container.add_child(label_blank)
	for behavior in sm_settings.behavior_dict:
		var label = Label.new()
		label.text = behavior
		behavior_labels_container.add_child(label)
	state_behavior_settings_container.add_child(behavior_labels_container)
	
	# Setup columns with state name and behaviors
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

func set_up_behavior_container():
	for behavior in sm_settings.behavior_dict:
		var behavior_node = sm.get_node_or_null(behavior)
		if behavior_node != null:
			add_behavior_settings(behavior_node)
		else:
			print("Error: could not load behavior '" + behavior + "'")

func _on_btn_add_behavior_pressed():
	var behavior
	add_behavior_settings(create_bahavior(new_behavior_selector.get_selected_metadata()))
	new_behavior_selector.selected = -1

# Instantiates corresponding StateBehavior Scene
# Adds to object and updates object's state manager settings
func create_bahavior(behavior_scene):
	var behavior = behavior_scene.instantiate()
	sm.add_child(behavior)
	sm_settings.add_behavior(behavior.name)
	
	behavior.owner = editable_obj
	
	edited_object.emit(behavior)
	
	return behavior

# Instantiates corresponding StateBehaviorSettings Scene
func add_behavior_settings(behavior_node : StateBehavior):
	var comp_settings = component_settings_scn.instantiate()
	behavior_container.add_child(comp_settings)
	
	behavior_container.add_child(comp_settings)
	comp_settings.set_component(behavior_node, behavior_node.name)
	
	# update state behavior settings container
	set_up_state_behavior_settings_container()
	
func _on_btn_check_settings_pressed():
	print(sm_settings.behavior_dict)
