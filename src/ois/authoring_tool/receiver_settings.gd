extends MarginContainer

@export var actor_receiver_settings : ActorReceiverSettings

var editable_object
var receiver_components : Dictionary
var current_receiver_comp

@onready var collision_shape_selector = $ScrollContainer/Main/OptionBtnCollisionShape
@onready var receiver_comp_selector = $ScrollContainer/Main/OptionBtnReceiverComponent

@onready var action_comp_container = $ScrollContainer/Main/ActionCompContainer
@onready var feedback_container = $ScrollContainer/Main/FeedbackContainer
@onready var receiver_group_option_btn = $ScrollContainer/Main/ReceiverGroupOptionButton
@onready var receiver_group_container = $ScrollContainer/Main/ReceiverGroupContainer

var component_settings_scn = preload("res://src/ois/authoring_tool/component_settings.tscn")

# Can only handle objects that are receiver or have one node named "ReceiverComp"

func _ready():
	# Disable Inputs
	enable_inputs(false)
	collision_shape_selector.add_item("BoxShape3D")
	collision_shape_selector.set_item_metadata(0, BoxShape3D)
	collision_shape_selector.add_item("SphereShape3D")
	collision_shape_selector.set_item_metadata(1, SphereShape3D)
	collision_shape_selector.add_item("CylinderShape3D")
	collision_shape_selector.set_item_metadata(2, CylinderShape3D)
	collision_shape_selector.add_item("CapsuleShape3D")
	collision_shape_selector.set_item_metadata(3, CapsuleShape3D)

func set_up(obj):
	clear()
	editable_object = obj
	if obj == null:
		enable_inputs(false)
	else:
		enable_inputs(true)
		setup_receiver_option_btn()
		
		#if editable_object is ReceiverObj:
			#receiver_components.append(editable_object)
			#receiver_comp_selector.add_item(editable_object.name)
			#receiver_comp_selector.set_item_metadata(receiver_comp_selector.item_count-1, editable_object)
		#else:
			#for child in editable_object.get_children():
				#if child is ReceiverObj:
					#receiver_components.append(child)
					#receiver_comp_selector.add_item(child.name)
					#receiver_comp_selector.set_item_metadata(receiver_comp_selector.item_count-1, child)
		
		var has_collision_child = false
		
		for child in editable_object.get_children():
			if child is Area3D:
				var new_cont1 = VBoxContainer.new()
				var new_cont2 = VBoxContainer.new()
				var new_cont3 = VBoxContainer.new()
				
				action_comp_container.add_child(new_cont1)
				receiver_group_container.add_child(new_cont2)
				feedback_container.add_child(new_cont3)
				
				receiver_components[child] = [new_cont1, new_cont2, new_cont3]
				receiver_comp_selector.add_item(child.name)
				receiver_comp_selector.set_item_metadata(receiver_comp_selector.item_count-1, child)
				has_collision_child = true
		
		if !has_collision_child && !(editable_object is XRToolsPickable):
			var new_cont1 = VBoxContainer.new()
			var new_cont2 = VBoxContainer.new()
			var new_cont3 = VBoxContainer.new()
			
			action_comp_container.add_child(new_cont1)
			receiver_group_container.add_child(new_cont2)
			feedback_container.add_child(new_cont3)
			
			receiver_components[editable_object] = [new_cont1, new_cont2, new_cont3]
			receiver_comp_selector.add_item("Editable Object")
			receiver_comp_selector.set_item_metadata(receiver_comp_selector.item_count-1, editable_object)

		
		for receiver_comp in receiver_components.keys():
			if receiver_comp is ReceiverObj:
				var action_comp_settings = component_settings_scn.instantiate()
				action_comp_container.add_child(action_comp_settings)
				var action_comp_script = receiver_comp.get_script().get_path()
				var action_comp_name = action_comp_script.get_slice("/", action_comp_script.get_slice_count("/")-1).get_slice(".", 0) 
				action_comp_settings.set_component(receiver_comp, action_comp_name)
				receiver_components[receiver_comp][0] = action_comp_settings
				
				for group in receiver_comp.get_groups():
					var new_receiver_group = component_settings_scn.instantiate()
					receiver_components[receiver_comp][1].add_child(new_receiver_group)				
					var del_func = func():
						receiver_comp.remove_from_group(group)
						new_receiver_group.queue_free()
					new_receiver_group.set_component(null, group, del_func)
				
				for child in receiver_comp.get_children():
					if child is Feedback:
						var new_feedback_settings = component_settings_scn.instantiate()
						receiver_components[receiver_comp][2].add_child(new_feedback_settings)
						
						var del_func = func(): delete_feedback(child, new_feedback_settings)
						var rename_func = func(new_name): rename_feedback(child, new_name)
							
						new_feedback_settings.set_component(child, child.name, del_func, rename_func)

		receiver_comp_selector.selected = 0
		_on_option_btn_receiver_component_item_selected(0)
		
func clear():
	for child in receiver_group_container.get_children():
		child.queue_free()
	for child in action_comp_container.get_children():
		child.queue_free()
	for child in feedback_container.get_children():
		child.queue_free()
	receiver_comp_selector.clear()
	receiver_components.clear()

func enable_inputs(is_enabled : bool):
	$ScrollContainer/Main/BtnAddActionComp.disabled = !is_enabled
	$ScrollContainer/Main/BtnAddFeedback.disabled = !is_enabled

func _on_btn_add_action_comp_pressed():
	$FDSelectActionComp.visible = true

# assign action component to editable object
# create corresponding action component settings gui
func _on_fd_select_action_comp_file_selected(path):
	var action_comp_settings
	var temp
	if receiver_components[current_receiver_comp][0] != null:
		temp = receiver_components[current_receiver_comp][0]
	action_comp_settings = component_settings_scn.instantiate()
	action_comp_container.add_child(action_comp_settings)
	receiver_components[current_receiver_comp][0] = action_comp_settings
	temp.queue_free()
	
	current_receiver_comp.set_script(load(path))
	var action_comp_name = path.get_slice("/", path.get_slice_count("/")-1).get_slice(".", 0)
	action_comp_settings.set_component(current_receiver_comp, action_comp_name)

func _on_btn_add_feedback_pressed():
	$FDSelectFeedback.visible = true

func _on_fd_select_feedback_file_selected(path):
	# Create new feedback node
	var new_feedback_node = Node3D.new()
	var new_feedback_name = path.get_slice("/", path.get_slice_count("/")-1).get_slice(".", 0)
	
	new_feedback_node.set_script(load(path))
	new_feedback_node.name = new_feedback_name
	current_receiver_comp.add_child(new_feedback_node)
	new_feedback_node.owner = editable_object

	# Create feedback settings
	var new_feedback_settings = component_settings_scn.instantiate()
	receiver_components[current_receiver_comp][2].add_child(new_feedback_settings)
	
	# Connect feedback settings with corresponding node
	var del_func = func(): delete_feedback(new_feedback_node, new_feedback_settings)
	var rename_func = func(new_name): rename_feedback(new_feedback_node, new_name)
	new_feedback_settings.set_component(new_feedback_node, new_feedback_node.name, del_func, rename_func)

func delete_feedback(feedback_node, component_settings):
	feedback_node.queue_free()
	component_settings.queue_free()

func rename_feedback(feedback_node, new_name):
	feedback_node.name = new_name

func _on_btn_add_receiver_group_pressed():
	if receiver_group_option_btn.selected != -1:
		var receiver_group = receiver_group_option_btn.get_item_text(receiver_group_option_btn.get_selected_id())
		
		var new_receiver_group = component_settings_scn.instantiate()
		receiver_components[current_receiver_comp][1].add_child(new_receiver_group)
		
		var del_func = func():
			current_receiver_comp.remove_from_group(receiver_group)
			new_receiver_group.queue_free()

		new_receiver_group.set_component(null, receiver_group, del_func)
		
		current_receiver_comp.add_to_group(receiver_group, true)
		receiver_group_option_btn.selected = -1

func setup_receiver_option_btn():
	receiver_group_option_btn.clear()
	for i in actor_receiver_settings.receiver_groups:
		receiver_group_option_btn.add_item(i)
	receiver_group_option_btn.selected = -1


func _on_btn_set_collision_shape_pressed():
	var col_shape = current_receiver_comp.get_node_or_null("CollisionShape3D") as CollisionShape3D
	if col_shape != null:
		col_shape.shape = collision_shape_selector.get_selected_metadata().new()


func _on_btn_copy_main_collision_shape_pressed():
	var col_shape = current_receiver_comp.get_node_or_null("CollisionShape3D") as CollisionShape3D
	var main_col_shape = editable_object.get_node_or_null("CollisionShape3D") as CollisionShape3D
	if col_shape != null && main_col_shape != null && col_shape != main_col_shape:
		col_shape.shape = main_col_shape.shape.duplicate()


func _on_option_btn_receiver_component_item_selected(index):
	current_receiver_comp = receiver_comp_selector.get_selected_metadata()
	
	for child in receiver_group_container.get_children():
		child.visible = false
	for child in action_comp_container.get_children():
		child.visible = false
	for child in feedback_container.get_children():
		child.visible = false
	
	for comp in receiver_components[current_receiver_comp]:
		comp.visible = true
