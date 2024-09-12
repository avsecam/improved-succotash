extends Node3D

## Object Authoring Tool
##
## This tool allows one to easily create and set properties of objects
## Particularly, actor, receiver, and inventory objects
## Coordinates with ActorSettings, ReceiverSettings, InventorySettings scenes

signal changed_editable_object(object)

@onready var object_settings_container : TabContainer = $MainContainer/Panel/MarginContainer/BoxContainer/ObjectSettings
@onready var actor_settings = $MainContainer/Panel/MarginContainer/BoxContainer/ObjectSettings/ActorSettings
@onready var receiver_settings = $MainContainer/Panel/MarginContainer/BoxContainer/ObjectSettings/ReceiverSettings
@onready var inventory_settings = $MainContainer/Panel/MarginContainer/BoxContainer/ObjectSettings/InventorySettings

@onready var cd_new_object : ConfirmationDialog = $CDNewObject

@onready var notification_panel = $NotificationPanel

@onready var gizmo_controller = $Editor_Controller

@onready var editable_object_slot : Node3D = $EditableObjectSlot
var editable_object 

func _ready():
	PhysicsServer3D.set_active(false) # turn off physics
	get_tree().debug_collisions_hint = true # show colliders

## Add object to editable_object_slot
func add_editable_object(object):
	if(editable_object_slot.get_child(0) != null):
		editable_object_slot.get_child(0).queue_free()

	editable_object_slot.add_child(object)
	editable_object = object
	
	changed_editable_object.emit(editable_object)

## Replace mesh of MainMesh node upon selecting file path
func _on_fd_set_mesh_file_selected(path):
	var main_mesh = editable_object.get_node_or_null("MainMesh")
	if main_mesh != null && main_mesh is MeshInstance3D:
		main_mesh.mesh = load(path)

## Save object upon selecting file path in respective file dialogue
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

## Load object upon selecting file path in respective file dialogue
func _on_fd_load_object_file_selected(path):
	add_editable_object(load(path).instantiate())
	
	var is_actor = editable_object.get_node_or_null("StateManager") != null
	var is_receiver = editable_object is ReceiverObj || editable_object.get_node_or_null("ReceiverComp") != null
	var is_inventory = editable_object.get_node_or_null("InventoryItemComp") != null
	
	set_up_object_settings(editable_object, is_actor, is_receiver, is_inventory)

## Set up the various tabs in ObjectSettings and enables/disables input to certain settings accordingly
func set_up_object_settings(obj, is_actor: bool, is_receiver: bool, is_inventory : bool):
	object_settings_container.set_tab_disabled(1, !is_actor)
	object_settings_container.set_tab_disabled(2, !is_receiver)
	object_settings_container.set_tab_disabled(3, !is_inventory)
	
	if is_actor:
		actor_settings.set_up(obj)
	else:
		actor_settings.set_up(null)
	
	if is_receiver:
		receiver_settings.set_up(obj)
	else:
		receiver_settings.set_up(null)
		
	if is_inventory:
		inventory_settings.set_up(obj)
	else:
		inventory_settings.set_up(null)

	add_editable_object(obj)

## Handle button signals
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
