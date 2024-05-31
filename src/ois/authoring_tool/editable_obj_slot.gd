extends Node3D

var editable_obj

func set_editable_obj(obj):
	editable_obj = obj
	set_up_auth_view()

func set_up_auth_view():
	display_all_children_debug(editable_obj)

func display_obj_debug(obj):
	obj.visible = true
	if obj.has_method("debug_show"):
		obj.debug_show(true)
	if obj is XRToolsGrabPointHand:
		obj._update_editor_preview()

func display_all_children_debug(obj):
	for child in obj.get_children():
		if (child is Node3D) && !child.is_in_group("OISAuth_NoTransform"):
			print(child.name)
			display_obj_debug(child)
		if child is XRToolsGrabPointHand:
			pass
		elif child.get_child_count() > 0:
			display_all_children_debug(child)
