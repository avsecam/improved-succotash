extends Tree

@onready var ois_auth_tool = get_tree().get_root().get_node("OISAuthoringTool")
@onready var gizmo = ois_auth_tool.get_node("Editor_Controller")
var visibility_btn_texture: Texture = preload("res://src/authoring_tools/gizmos/icons/GuiVisibilityVisible.svg")


var editable_obj

func _ready():
	ois_auth_tool.changed_editable_object.connect(set_editable_obj)

func set_editable_obj(obj):
	editable_obj = obj
	set_up_tree(editable_obj)

func update_tree(new_component):
	set_up_tree(editable_obj)

func set_up_tree(obj):
	clear()
	var root = create_item()
	hide_root = true

	# only checks first two layers of children for now
	for child in obj.get_children():
		if (child is Node3D) && !child.is_in_group("OISAuth_NoTransform"):
			var child_item = add_tree_item(root, child)
			if child is StateManager:
				for c in child.get_children():
					if (c is Node3D) && !c.is_in_group("OISAuth_NoTransform"):
						add_tree_item(child_item, c)

func add_tree_item(tree_parent, node):
	var tree_item = create_item(tree_parent)
	tree_item.set_text(0, node.name)
	tree_item.set_metadata(0, node)
	tree_item.add_button(0, visibility_btn_texture)
	#tree_item.item_selected.connect(on_item_pressed).bind(node)
	return tree_item

func set_gizmo_obj_config(obj):
	gizmo.set_gizmo_scale(0.05)
	if obj is StateBehavior:
		gizmo.set_object_and_gizmos(obj, false, true, true, false)
	else:
		gizmo.set_object_and_gizmos(obj, false, true, true, true)
		

func _on_item_selected():
	if get_selected().get_metadata(0) != null:
		set_gizmo_obj_config(get_selected().get_metadata(0))


func _on_button_clicked(item, column, id, mouse_button_index):
	if (column == 0 && id == 0):
		if item.get_metadata(0) != null:
			item.get_metadata(0).visible = !item.get_metadata(0).visible
			if item.get_metadata(0).visible == true:
				item.set_button_color(column, id, Color.WHITE)
			else:
				item.set_button_color(column, id, Color.DIM_GRAY)
