@tool
extends MeshInstance3D

var inventory_state_scene = preload("res://src/ois/states/state_inventory.tscn")
var inventory_state

@onready var main_mesh = get_parent().get_node_or_null("MainMesh")

@onready var state_manager = get_parent().get_node_or_null("StateManager")


func _ready():
	toggle_replacement_mesh()
	get_parent().add_to_group("Objects")
	if state_manager != null:
		inventory_state = inventory_state_scene.instantiate()
		state_manager.add_child(inventory_state)

func toggle_replacement_mesh() -> void:
	print(self.name+" | Toggled replacement mesh OFF.")	
	main_mesh.visible = true
	visible = false
	
func toggle_main_mesh() -> void:
	print(self.name+" | Toggled main mesh OFF.")	
	main_mesh.visible = false
	visible = true
	if state_manager != null && inventory_state != null:
		inventory_state.add_to_inventory()

func _get_configuration_warnings():
	var warnings = []
	
	var has_grab_point = false
	for i in get_parent().get_children():
		if i is XRToolsGrabPointHand:
			has_grab_point = true
			break
	
	if !has_grab_point:
		warnings.append("Add GrabPointHand")

	# Returning an empty array means "no warning".
	return warnings
