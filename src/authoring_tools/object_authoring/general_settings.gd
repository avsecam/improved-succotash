extends MarginContainer

@onready var collision_shape_selector = $BoxContainer/OptionBtnCollisionShape
@onready var editable_obj_slot = $"../../../../../../EditableObjectSlot"

func _ready():
	collision_shape_selector.add_item("BoxShape3D")
	collision_shape_selector.set_item_metadata(0, BoxShape3D)
	collision_shape_selector.add_item("SphereShape3D")
	collision_shape_selector.set_item_metadata(1, SphereShape3D)
	collision_shape_selector.add_item("CylinderShape3D")
	collision_shape_selector.set_item_metadata(2, CylinderShape3D)
	collision_shape_selector.add_item("CapsuleShape3D")
	collision_shape_selector.set_item_metadata(3, CapsuleShape3D)



func _on_btn_set_collision_shape_pressed():
	if editable_obj_slot.get_child_count() > 0:
		var edit_obj = editable_obj_slot.get_child(0)
		var col_shape = edit_obj.get_node_or_null("CollisionShape3D") as CollisionShape3D
		if col_shape != null:
			col_shape.shape = collision_shape_selector.get_selected_metadata().new()
