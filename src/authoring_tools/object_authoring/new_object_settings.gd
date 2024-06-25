extends ConfirmationDialog

@onready var ois_authoring_tool = get_parent()

@onready var cb_pickable = $NewObjectSettings/CBPickable
@onready var cb_staticbody = $NewObjectSettings/CBStaticBody
@onready var cb_rigidbody = $NewObjectSettings/CBRigidBody

@onready var cb_actor = $NewObjectSettings/CBActor
@onready var cb_receiver = $NewObjectSettings/CBReceiver
@onready var cb_inventory = $NewObjectSettings/CBInventory
@onready var actor_type_selector = $NewObjectSettings/ActorTypeSelector

# Preload Scenes for creating objects
var pickable_scene = preload("res://src/ois/pickable_template.tscn")
var sm_one_handed_tool_scene = preload("res://src/ois/state_managers/one_handed_tool.tscn")
var sm_two_handed_tool_scene = preload("res://src/ois/state_managers/two_handed_tool.tscn")
var inventory_component_scene = preload("res://src/inventory/inventory_item_comp.tscn")

# Create object given checkbox settings
# Configure checkbox settings given implementation restrictions and considerations

# Current restrictions include:
# Cannot easily have object be receiver and actor at once
# Cannot be a receiver and inventory object

# Other considerations include:
# To simplify implementation and given escape room context,
# don't allow an inventory item that is not an actor object

func _ready():
	actor_type_selector.add_item("One-Handed Tool")
	actor_type_selector.add_item("Two-Handed Tool")
	
	reset()

func reset():
	get_ok_button().disabled = true
	cb_receiver.disabled = true
	cb_actor.disabled = true
	cb_inventory.disabled = true
	actor_type_selector.selected = -1
	# reset checkboxes
	cb_pickable.button_pressed = false
	cb_staticbody.button_pressed = false
	cb_rigidbody.button_pressed = false
	cb_actor.button_pressed = false
	cb_receiver.button_pressed = false
	cb_inventory.button_pressed = false

func _on_confirmed():
	var new_obj
	var is_actor = false
	var is_receiver = false
	var is_inventory = false
	
	# Set up base object
	if cb_pickable.button_pressed:
		new_obj = pickable_scene.instantiate()
		var collision_shape = new_obj.get_node("CollisionShape3D")
		collision_shape.shape = BoxShape3D.new()
		collision_shape.shape.size = Vector3(0.1, 0.1, 0.1)
	else:
		if cb_staticbody.button_pressed:
			new_obj = StaticBody3D.new()
		elif cb_rigidbody.button_pressed:
			new_obj = RigidBody3D.new()
		add_placeholder_mesh(new_obj, new_obj)
		add_placeholder_collider(new_obj, new_obj)
	
	# Set up additional object settings
	if cb_actor.button_pressed:
		var new_sm
		if actor_type_selector.selected == 0:
			new_sm = sm_one_handed_tool_scene.instantiate()
		else:
			new_sm = sm_two_handed_tool_scene.instantiate()
		new_sm.in_authoring_tool = true
		new_obj.add_child(new_sm)
		new_sm.owner = new_obj
		is_actor = true
		
	if cb_receiver.button_pressed:
		if cb_pickable.button_pressed:
			var new_receiver_area = Area3D.new()
			new_obj.add_child(new_receiver_area)
			new_receiver_area.name = "ReceiverComp"
			new_receiver_area.owner = new_obj
			add_placeholder_collider(new_obj, new_receiver_area)
		is_receiver = true
		
	if cb_inventory.button_pressed:
		var new_inventory_comp = inventory_component_scene.instantiate()
		new_obj.add_child(new_inventory_comp)
		new_inventory_comp.owner = new_obj
		is_inventory = true
	
	ois_authoring_tool.set_up_object_settings(new_obj, is_actor, is_receiver, is_inventory)

func add_placeholder_mesh(owner, parent):
	var new_mesh = MeshInstance3D.new()
	new_mesh.name = "MainMesh"
	new_mesh.mesh = BoxMesh.new()
	new_mesh.mesh.size = Vector3(0.1, 0.1, 0.1)
	parent.add_child(new_mesh)
	new_mesh.owner = owner
	
func add_placeholder_collider(owner, parent):
	var new_collision_shape = CollisionShape3D.new()
	new_collision_shape.name = "CollisionShape3D"
	new_collision_shape.shape = BoxShape3D.new()
	new_collision_shape.shape.size = Vector3(0.1, 0.1, 0.1)
	parent.add_child(new_collision_shape)
	new_collision_shape.owner = owner

# Configure checkbox settings 
func _on_cb_pickable_toggled(toggled_on):
	cb_staticbody.disabled = toggled_on
	cb_rigidbody.disabled = toggled_on
	get_ok_button().disabled = !toggled_on
	
	cb_receiver.disabled = !toggled_on
	cb_actor.disabled = !toggled_on
	cb_inventory.disabled = !toggled_on
	
	if !toggled_on:
		cb_receiver.button_pressed = false
		cb_actor.button_pressed = false
		actor_type_selector.selected = -1
		cb_inventory.button_pressed = false

func _on_cb_static_body_toggled(toggled_on):
	cb_rigidbody.disabled = toggled_on
	cb_pickable.disabled = toggled_on
	get_ok_button().disabled = !toggled_on

	cb_receiver.disabled = !toggled_on
	
	if !toggled_on:
		cb_receiver.button_pressed = false
		
func _on_cb_rigid_body_toggled(toggled_on):
	cb_staticbody.disabled = toggled_on
	cb_pickable.disabled = toggled_on
	get_ok_button().disabled = !toggled_on
	
	cb_receiver.disabled = !toggled_on
	
	if !toggled_on:
		cb_receiver.button_pressed = false

func _on_cb_actor_toggled(toggled_on):
	if toggled_on:
		actor_type_selector.selected = 0
	else:
		actor_type_selector.selected = -1
