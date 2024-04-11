extends XRToolsSnapZone

var current_inventory_obj

func _on_has_dropped():
	current_inventory_obj.toggle_replacement_mesh()
	# Transfer object parent from snapzone to actual slot.
	self.get_parent().remove_child(current_inventory_obj)
	# If object is currently in slot, remove parent before adding to World.
	var temp_parent = current_inventory_obj.get_node("../../../..")
	print("!!!!! " + temp_parent.get_name())
	if current_inventory_obj.get_parent().get_name() == "Inventory Content":
		current_inventory_obj.get_parent().remove_child(current_inventory_obj)
	# index is set to 1 because XRUserSettings is child 0 -- will check if there's a better implementation
	temp_parent.add_child(current_inventory_obj)


func _on_has_picked_up(picked_up_object):
	current_inventory_obj = picked_up_object
	print("Picked up " + current_inventory_obj.name)
	current_inventory_obj.toggle_main_mesh()
	
	# Add as child of node to ensure better movement
	current_inventory_obj.get_parent().remove_child(current_inventory_obj)
	self.get_parent().get_node("Inventory Content").add_child(current_inventory_obj)
