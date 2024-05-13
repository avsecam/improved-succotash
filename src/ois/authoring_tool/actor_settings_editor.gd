extends SplitContainer

@onready var cb_cont = $SplitContainer/StateBehaviorEditor/CBContainer
@onready var behavior_list = $BoxContainer/ItemList
@onready var b_container = $BoxContainer/ScrollContainer/BContainer

var raycast_settings = preload("res://src/ois/authoring_tool/sb_raycast.tscn")
var snap_settings = preload("res://src/ois/authoring_tool/sb_snap.tscn")
var interact_settings = preload("res://src/ois/authoring_tool/sb_interact.tscn")

var state_behavior_cb = preload("res://src/ois/authoring_tool/state_behavior_cb.tscn")

var ois_authoring
var sm
var sm_settings : StateManagerSettings
var sm_settings_path


func set_up(obj):
	#ois_authoring = get_node("/root/OISAuthoringTool")
	#print(ois_authoring.name)
	sm = obj.get_node_or_null("StateManager")
	if sm is StateManager:
		sm_settings = sm.settings
		print(sm_settings.settings)
		sm_settings_path = sm.settings.get_path()
		print(sm_settings_path)
		set_up_grid()

func set_up_grid():
	clear_cbs()
	var flow_cont_labels = GridContainer.new()
	flow_cont_labels.columns = 1
	var label_blank = Label.new()
	label_blank.text = ""
	flow_cont_labels.add_child(label_blank)
	for behavior in sm_settings.behavior_dict:
		var label = Label.new()
		label.text = behavior
		flow_cont_labels.add_child(label)
		behavior_list.add_item(behavior)
	cb_cont.add_child(flow_cont_labels)
	
	print(sm_settings.settings)
	for state in sm_settings.settings:
		
		var flow_cont = GridContainer.new()
		var label = Label.new()
		label.text = state
		flow_cont.add_child(label)
		for behavior in sm_settings.settings[state]:
			var cb = state_behavior_cb.instantiate()
			cb.state = state
			cb.behavior = behavior
			cb.name = state + "." + behavior
			cb.button_pressed = sm_settings.settings[state][behavior]
			flow_cont.add_child(cb)
			cb.change_value.connect(sm_settings.change_value)
			var beh
			if (behavior == "raycast"):
				beh = raycast_settings.instantiate()
				b_container.add(beh)
			elif  (behavior == "snap"):
				beh = snap_settings.instantiate()
				b_container.add(beh)
			elif (behavior == "interact"):
				beh = interact_settings.instantiate()
				b_container.add(beh)
				
		cb_cont.add_child(flow_cont)


func _on_button_pressed():
	print(sm_settings.settings)
	ResourceSaver.save(sm_settings, sm_settings_path)

func clear_cbs():
	behavior_list.clear()
	for child in cb_cont.get_children():
		child.queue_free()
