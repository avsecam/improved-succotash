extends MarginContainer

var editable_obj
var inventory_item_comp

func set_up(editable_obj):
	self.editable_obj = editable_obj

	if editable_obj != null:
		inventory_item_comp = editable_obj.get_node("InventoryItemComp")

func _on_btn_load_mesh_pressed():
	$FDLoadMesh.visible = true

func _on_fd_load_mesh_file_selected(path):
	inventory_item_comp.visible = true
	inventory_item_comp.mesh = load(path)

func _on_btn_duplicate_main_mesh_pressed():
	var main_mesh = editable_obj.get_node_or_null("MainMesh")
	if main_mesh is MeshInstance3D:
		inventory_item_comp.visible = true
		inventory_item_comp.mesh = main_mesh.mesh.duplicate()
		inventory_item_comp.transform = main_mesh.transform

# TODO add inventory view
