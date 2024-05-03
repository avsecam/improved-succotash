extends Control

@onready var confirmation_dialog : ConfirmationDialog = $ConfirmationDialog
@onready var editable_object_slot : Node3D = $MainContainer/LeftHalf/SubViewportContainer/SubViewport/EditableObjectSlot
@onready var object_settings = $MainContainer/ObjectSettings

var pickable_scene = preload("res://addons/godot-xr-tools/objects/pickable.tscn")

var editable_object 

func _ready():
	PhysicsServer3D.set_active(false) # turn off physics
	toggle_object_settings(false)

func toggle_object_settings(toggle : bool):
	for child in object_settings.get_children():
		if child is Button:
			child.disabled = !toggle

func add_editable_object(object):
	if(editable_object_slot.get_child(0) != null):
		editable_object_slot.get_child(0).queue_free()
	editable_object_slot.add_child(object)
	editable_object = object
	toggle_object_settings(true)

func _on_fd_set_mesh_file_selected(path):
	for child in editable_object.get_children():
		if child is MeshInstance3D:
			child.mesh = load(path)
			break

func _on_fd_save_object_file_selected(path):
	var new_name = path.get_slice("/", path.get_slice_count("/")-1)
	editable_object.name = new_name.get_slice(".", 0)
	
	var scene = PackedScene.new()
	scene.pack(editable_object)
	var error = ResourceSaver.save(scene, path)
	if error != OK:
		push_error("An error occurred while saving the scene to disk.")

func _on_fd_load_object_file_selected(path):
	add_editable_object(load(path).instantiate())

func _on_btn_new_object_pressed():
	# let users set if object is/are receiver, actor, inventory objects
	
	var new_obj = pickable_scene.instantiate()
	var new_mesh = MeshInstance3D.new()
	new_mesh.mesh = BoxMesh.new()
	new_obj.add_child(new_mesh)
	new_mesh.owner = new_obj
	add_editable_object(new_obj)

func _on_btn_load_object_pressed():
	$FDLoadObject.visible = true

func _on_btn_save_object_pressed():
	if editable_object != null:
		$FDSaveObject.visible = true

func _on_btn_set_mesh_pressed():
	if editable_object != null:
		$FDSetMesh.visible = true
