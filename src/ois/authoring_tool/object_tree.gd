extends Tree

@onready var ois_auth_tool = get_tree().get_root().get_node("OISAuthoringTool")
@onready var gizmo = ois_auth_tool.get_node("Editor_Controller")
@export var editable_obj : XRToolsPickable

func _ready():
	ois_auth_tool.changed_editable_object.connect(set_up_tree)

func set_up_tree(obj):
	clear()
	var root = create_item()
	hide_root = true
	
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
