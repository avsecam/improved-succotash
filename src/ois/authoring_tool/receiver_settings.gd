extends MarginContainer

var editable_object
@onready var action_comp_container = $ScrollContainer/Main/ActionCompContainer
@onready var feedback_container = $ScrollContainer/Main/FeedbackContainer

var component_settings_scn = preload("res://src/ois/authoring_tool/component_settings.tscn")

func set_editable_object(obj):
	print("set_editable_object")
	editable_object = obj

func _on_btn_add_action_comp_pressed():
	$FDSelectActionComp.visible = true

# assign action component to editable object
# create corresponding action component settings gui
func _on_fd_select_action_comp_file_selected(path):
	var action_comp_settings
	if action_comp_container.get_child(0) != null:
		action_comp_container.get_child(0).queue_free()
	action_comp_settings = component_settings_scn.instantiate()
	action_comp_container.add_child(action_comp_settings)
	
	editable_object.set_script(load(path))
	var action_comp_name = path.get_slice("/", path.get_slice_count("/")-1).get_slice(".", 0)
	action_comp_settings.set_component(editable_object, action_comp_name)	

func _on_btn_add_feedback_pressed():
	$FDSelectFeedback.visible = true

func _on_fd_select_feedback_file_selected(path):
	var new_feedback_settings = component_settings_scn.instantiate()
	feedback_container.add_child(new_feedback_settings)
	
	var new_feedback_node = Node3D.new()
	var new_feedback_name = path.get_slice("/", path.get_slice_count("/")-1).get_slice(".", 0)
	
	new_feedback_node.set_script(load(path))
	new_feedback_node.name = new_feedback_name
	editable_object.add_child(new_feedback_node)
	new_feedback_node.owner = editable_object
	
	new_feedback_settings.set_component(new_feedback_node, new_feedback_name)
