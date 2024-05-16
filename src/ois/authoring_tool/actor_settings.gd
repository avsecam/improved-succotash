extends SplitContainer

var state_behavior_cb = preload("res://src/ois/authoring_tool/state_behavior_cb.tscn")

@onready var behavior_container = $BoxContainer/ScrollContainer/BahaviorContainer
@onready var state_behavior_settings_container = $SplitContainer/Panel/ScrollContainer/StateBehaviorSettingsContainer

var sm : StateManager
var sm_settings : StateManagerSettings

func set_up_actor_settings(obj):
	sm = obj.get_node_or_null("StateManager")
	if sm is StateManager:
		sm_settings = sm.settings
		print(sm_settings.state_behavior_settings)
		set_up_grid()

func clear_actor_settings():
	for child in state_behavior_settings_container.get_children():
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
			cb.change_value.connect(sm_settings.change_value)
			#var beh
			#if (behavior == "raycast"):
				#beh = raycast_settings.instantiate()
				#b_container.add(beh)
			#elif  (behavior == "snap"):
				#beh = snap_settings.instantiate()
				#b_container.add(beh)
			#elif (behavior == "interact"):
				#beh = interact_settings.instantiate()
				#b_container.add(beh)
		state_behavior_settings_container.add_child(box_cont)

func _on_btn_add_behavior_pressed():
	pass # Replace with function body.
