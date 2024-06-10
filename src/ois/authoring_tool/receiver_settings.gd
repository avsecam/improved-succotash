extends MarginContainer

var editable_object
@onready var action_comp_container = $ScrollContainer/Main/ActionCompContainer
@onready var feedback_container = $ScrollContainer/Main/FeedbackContainer

var component_settings_scn = preload("res://src/ois/authoring_tool/component_settings.tscn")

func _ready():
	# Disable Inputs
	enable_inputs(false)

func set_up(obj):
	clear()
	editable_object = obj
	if obj == null:
		enable_inputs(false)
	else:
		enable_inputs(true)
		
		if editable_object is ReceiverObj:
			var action_comp_settings = component_settings_scn.instantiate()
			action_comp_container.add_child(action_comp_settings)
			var action_comp_script = editable_object.get_script().get_path()
			var action_comp_name = action_comp_script.get_slice("/", action_comp_script.get_slice_count("/")-1).get_slice(".", 0) 
			action_comp_settings.set_component(editable_object, action_comp_name)
		for child in editable_object.get_children():
			if child is Feedback:
				var new_feedback_settings = component_settings_scn.instantiate()
				feedback_container.add_child(new_feedback_settings)
				
				var del_func = func(): delete_feedback(child, new_feedback_settings)
				var rename_func = func(new_name): rename_feedback(child, new_name)
					
				new_feedback_settings.set_component(child, child.name, del_func, rename_func)

func clear():
	for child in action_comp_container.get_children():
		child.queue_free()
	for child in feedback_container.get_children():
		child.queue_free()

func enable_inputs(is_enabled : bool):
	$ScrollContainer/Main/BtnAddActionComp.disabled = !is_enabled
	$ScrollContainer/Main/BtnAddFeedback.disabled = !is_enabled

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
	# Create new feedback node
	var new_feedback_node = Node3D.new()
	var new_feedback_name = path.get_slice("/", path.get_slice_count("/")-1).get_slice(".", 0)
	
	new_feedback_node.set_script(load(path))
	new_feedback_node.name = new_feedback_name
	editable_object.add_child(new_feedback_node)
	new_feedback_node.owner = editable_object

	# Create feedback settings
	var new_feedback_settings = component_settings_scn.instantiate()
	feedback_container.add_child(new_feedback_settings)
	
	# Connect feedback settings with corresponding node
	var del_func = func(): delete_feedback(new_feedback_node, new_feedback_settings)
	var rename_func = func(new_name): rename_feedback(new_feedback_node, new_name)
	new_feedback_settings.set_component(new_feedback_node, new_feedback_node.name, del_func, rename_func)

func delete_feedback(feedback_node, component_settings):
	feedback_node.queue_free()
	component_settings.queue_free()

func rename_feedback(feedback_node, new_name):
	feedback_node.name = new_name
