extends MarginContainer

var editable_obj
var inventory_item_comp
var replacement_mesh : MeshInstance3D

func set_up(editable_obj):
	self.editable_obj = editable_obj

	if editable_obj != null:
		inventory_item_comp = editable_obj.get_node("InventoryItemComp")
		replacement_mesh = inventory_item_comp.get_node_or_null("ReplacementMesh")
		if replacement_mesh == null:
			replacement_mesh = MeshInstance3D.new()
			replacement_mesh.name = "ReplacementMesh"
			inventory_item_comp.add_child(replacement_mesh)
			replacement_mesh.owner = editable_obj

func _on_btn_load_mesh_pressed():
	$FDLoadMesh.visible = true

func _on_fd_load_mesh_file_selected(path):
	replacement_mesh.visible = true
	replacement_mesh.mesh = load(path)

func _on_btn_duplicate_main_mesh_pressed():
	var main_mesh = editable_obj.get_node("MainMesh")
	if main_mesh.get_child_count() > 0 && main_mesh.get_child(0) is MeshInstance3D:
		replacement_mesh.visible = true
		replacement_mesh.mesh = main_mesh.get_child(0).mesh.duplicate()

# TODO add inventory view
