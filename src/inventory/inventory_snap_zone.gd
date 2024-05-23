extends XRToolsSnapZone

var current_inventory_obj
var current_inventory_item_comp

# TODO: Consider transition from using inventory_item objects to using inventory_item_comp
# If one wants to make object inventory object, just add inventory_item_comp

func _on_has_dropped():
	# handles objects using inventory_item scene (old)
	if current_inventory_obj.has_method("toggle_replacement_mesh"):
		current_inventory_obj.toggle_replacement_mesh()
	# handles objects using inventory_item_comp (new)
	elif current_inventory_item_comp != null:
		current_inventory_item_comp.toggle_main_mesh()
	
	# Transfer object parent from snapzone to actual slot.
	self.get_parent().remove_child(current_inventory_obj)
	# If object is currently in slot, remove parent before adding to World.
	if current_inventory_obj.get_parent().get_name() == "Inventory Content":
		current_inventory_obj.get_parent().remove_child(current_inventory_obj)
	# index is set to 1 because XRUserSettings is child 0 -- will check if there's a better implementation
	get_tree().get_root().get_child(1).add_child(current_inventory_obj)
	
	#current_inventory_obj = null
	current_inventory_item_comp = null

func _on_has_picked_up(picked_up_object):
	current_inventory_obj = picked_up_object
	print("Picked up " + current_inventory_obj.name)
	
	current_inventory_item_comp = current_inventory_obj.get_node_or_null("InventoryItemComp")
	
	# handles objects using inventory_item scene (old)
	if current_inventory_obj.has_method("toggle_main_mesh"):
		current_inventory_obj.toggle_main_mesh()
	# handles objects using inventory_item_comp (new)
	elif current_inventory_item_comp != null:
		current_inventory_item_comp.toggle_main_mesh()
		
	# Add as child of node to ensure better movement
	current_inventory_obj.get_parent().remove_child(current_inventory_obj)
	self.get_parent().get_node("Inventory Content").add_child(current_inventory_obj)
