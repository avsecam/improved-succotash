extends Node3D

signal changed_editable_object(object)


@onready var object_settings_container : TabContainer = $MainContainer/Panel/MarginContainer/BoxContainer/ObjectSettings
@onready var actor_settings = $MainContainer/Panel/MarginContainer/BoxContainer/ObjectSettings/ActorSettings
@onready var receiver_settings = $MainContainer/Panel/MarginContainer/BoxContainer/ObjectSettings/ReceiverSettings
# @onready var inventory_settings
# New Object Settings
@onready var cd_new_object : ConfirmationDialog = $CDNewObject
@onready var cb_actor : CheckBox = $CDNewObject/NewObjectSettings/CBActor
@onready var cb_receiver : CheckBox = $CDNewObject/NewObjectSettings/CBReceiver
@onready var cb_inventory : CheckBox = $CDNewObject/NewObjectSettings/CBInventory

@onready var notification_panel = $NotificationPanel

@onready var gizmo_controller = $Editor_Controller

@onready var editable_object_slot : Node3D = $EditableObjectSlot
var editable_object 

# Preload Scenes for creating objects
var pickable_scene = preload("res://addons/godot-xr-tools/objects/pickable.tscn")
var receiver_scene = preload("res://src/ois/action_components/receiver_object_static.tscn")
var actor_scene = preload("res://src/ois/actor_object.tscn")
var sm_one_handed_tool_scene = preload("res://src/ois/state_managers/one_handed_tool.tscn")
var inventory_component_scene = preload("res://src/inventory/inventory_item_comp.tscn")

func _ready():
	PhysicsServer3D.set_active(false) # turn off physics
	object_settings_container.set_tab_hidden(3, true)

func add_editable_object(object):
	if(editable_object_slot.get_child(0) != null):
		editable_object_slot.get_child(0).queue_free()

	editable_object_slot.add_child(object)
	editable_object = object
	
	changed_editable_object.emit(editable_object)

func _on_fd_set_mesh_file_selected(path):
	for child in editable_object.get_children():
		if child is MeshInstance3D:
			child.mesh = load(path)
			break

func _on_fd_save_object_file_selected(path):
	var new_name = path.get_slice("/", path.get_slice_count("/")-1)
	editable_object.name = new_name.get_slice(".", 0)
	
	if actor_settings.sm_settings != null:
		actor_settings.sm.settings = actor_settings.sm_settings
	
	var scene = PackedScene.new()
	scene.pack(editable_object)
	var error = ResourceSaver.save(scene, path)
	if error != OK:
		push_error("An error occurred while saving the scene to disk.")
		notification_panel.show_notification("An error occurred while saving the scene to disk.")
	else:
		print("Saved object to %s" % path)
		notification_panel.show_notification("Saved object to %s" % path)

func _on_fd_load_object_file_selected(path):
	add_editable_object(load(path).instantiate())
	object_settings_container.current_tab = 3
	
	if editable_object.get_node_or_null("StateManager") != null:
		actor_settings.set_up(editable_object)
		object_settings_container.set_tab_disabled(0, false)
		object_settings_container.current_tab = 0
	else:
		actor_settings.set_up(null)
		object_settings_container.set_tab_disabled(0, true)

	if editable_object is ReceiverObj:
		receiver_settings.set_up(editable_object)
		object_settings_container.set_tab_disabled(1, false)
		object_settings_container.current_tab = 1
	else:
		receiver_settings.set_up(null)
		object_settings_container.set_tab_disabled(1, true)

	if editable_object.get_node_or_null("InventoryItemComp") != null:
		object_settings_container.set_tab_disabled(2, false)
		object_settings_container.current_tab = 2
	else:
		object_settings_container.set_tab_disabled(2, true)
		
func _on_btn_new_object_pressed():
	# let users set if object is/are receiver, actor, inventory objects
	cd_new_object.reset()
	cd_new_object.popup_centered()

func _on_btn_load_object_pressed():
	$FDLoadObject.visible = true

func _on_btn_save_object_pressed():
	if editable_object != null:
		$FDSaveObject.visible = true

func _on_btn_set_mesh_pressed():
	if editable_object != null:
		$FDSetMesh.visible = true


func _on_cd_new_object_confirmed():
	var new_obj

	object_settings_container.current_tab = 3
	
	if cb_actor.button_pressed:
		print("Actor yes")
		new_obj = actor_scene.instantiate()
		
		var new_sm = sm_one_handed_tool_scene.instantiate()
		new_sm.in_authoring_tool = true
		new_obj.add_child(new_sm)
		new_sm.owner = new_obj
		
		object_settings_container.set_tab_disabled(0, false)
		object_settings_container.current_tab = 0
		actor_settings.set_up(new_obj)
	else:
		actor_settings.set_up(null)
		object_settings_container.set_tab_disabled(0, true)
	
	if cb_receiver.button_pressed:
		print("Receiver yes")
		new_obj = receiver_scene.instantiate()
		receiver_settings.set_up(new_obj)
		object_settings_container.set_tab_disabled(1, false)
		object_settings_container.current_tab = 1
	else:
		receiver_settings.set_up(null)
		object_settings_container.set_tab_disabled(1, true)
		
	if cb_inventory.button_pressed:
		print("Inventory yes")
		var new_inventory_comp = inventory_component_scene.instantiate()
		new_obj.add_child(new_inventory_comp)
		new_inventory_comp.owner = new_obj
		
		object_settings_container.set_tab_disabled(2, false)
		object_settings_container.current_tab = 2
	else:
		object_settings_container.set_tab_disabled(2, true)
	
	var new_mesh = MeshInstance3D.new()
	new_mesh.mesh = BoxMesh.new()
	new_mesh.mesh.size = Vector3(0.1, 0.1, 0.1)
	new_obj.get_node("MainMesh").add_child(new_mesh)
	new_mesh.owner = new_obj
	add_editable_object(new_obj)
