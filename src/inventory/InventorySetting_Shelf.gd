extends Node3D

@export var inventory_array = []
@export var inventory_size : int
@export var start_inv_array = []

# Called when the node enters the scene tree for the first time.
func _ready():
	
	if InventoryPersistence.global_inv_array.size() != 0:
		print("Reading from global inventory array.")
		inventory_size = InventoryPersistence.global_inv_array.size()
		print ("Inventory size is: "+ str(inventory_size))
		var count = 0
		for i in InventoryPersistence.global_inv_array:
			if i == null:
				print("Slot is NULL.")
			else:
				var current_inventory_obj = load(i).instantiate()
				add_child(current_inventory_obj)
				print("Picked up " + current_inventory_obj.name)
				current_inventory_obj.toggle_main_mesh()
				self.get_child(count+1).get_node("SnapZone").pick_up_object(current_inventory_obj)
				current_inventory_obj.get_parent().remove_child(current_inventory_obj)
				self.get_child(count+1).get_node("Inventory Content").add_child(current_inventory_obj)
			count += 1
	else:
		print("Fresh instantiation.")
		start_inv_array = get_tree().get_nodes_in_group("InventorySlot_Shelf")
		inventory_size = start_inv_array.size()
		
	
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):	
	pass
	
func _check_inventory_status():
	print(self.get_name()+ " | CALLED INVENTORY STATUS CHECK")
	print(str(inventory_array.size()) +" << scene shelf size B4|B4 persistence size >> " + str(InventoryPersistence.global_inv_array.size()))
	print("========================")
	if start_inv_array.size() == 0:
		start_inv_array = get_tree().get_nodes_in_group("InventorySlot_Shelf")
		inventory_size = start_inv_array.size()
	inventory_array.clear()
	InventoryPersistence.global_inv_array.clear()
	#print("Inventory system CLEAR:" + str(inventory_array.size()))
	for i in start_inv_array:
		if i.get_node("Inventory Content").get_child_count() != 0:
			inventory_array.append(i.get_node("Inventory Content").get_child(0))
			print(i.get_node("Inventory Content").get_child(0).scene_file_path)
			InventoryPersistence.global_inv_array.append(i.get_node("Inventory Content").get_child(0).scene_file_path)
		else:
			var object = null
			print("NO APPEND OK??")
			inventory_array.append(object)
			InventoryPersistence.global_inv_array.append(object)
	print("========================")
	print(str(inventory_array.size()) +" << scene shelf size | persistence size >> " + str(InventoryPersistence.global_inv_array.size()))
	#print("Inventory system item count:" + str(inventory_array.size()))
					

#func _on_snap_zone_body_entered(target: Node3D) -> void:
	## Call method when something enters or exits the inventory system.
	## Check current state of the array
	##print("Snapzone body entered CALLED")
	#_check_inventory_status()

func _on_snap_zone_body_exited(target: Node3D) -> void:
	#Call method when something enters or exits the inventory system.
	#Check current state of the array
	#print("Snapzone body exited CALLED")
	_check_inventory_status()
