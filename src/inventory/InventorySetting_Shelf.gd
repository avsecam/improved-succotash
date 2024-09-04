extends Node3D

signal inventory_updated()

@export var inventory_array = []
@export var inventory_size : int
var start_inv_array = []

# Called when the node enters the scene tree for the first time.
func _ready():

	start_inv_array = get_tree().get_nodes_in_group("InventorySlot_Shelf")
	inventory_size = start_inv_array.size()
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):	
	pass
	
func _check_inventory_status():
	inventory_array.clear()
	print("Inventory system CLEAR:" + str(inventory_array.size()))
	for i in start_inv_array:
		if i.get_node("Inventory Content").get_child_count() != 0:
			inventory_array.append(i.get_node("Inventory Content").get_child(0))
		else:
			var object = null
			inventory_array.append(object)
	print("Inventory system item count:" + str(inventory_array.size()))
	for i in inventory_array:
		if i != null:
			print("Slot: "+i.name)
		else:
			print("No object in Slot")
					

func _on_snap_zone_body_entered(target: Node3D) -> void:
	# Call method when something enters or exits the inventory system.
	# Check current state of the array
	#print("Snapzone body entered CALLED")
	emit_signal("inventory_updated")
	_check_inventory_status()

func _on_snap_zone_body_exited(target: Node3D) -> void:
	# Call method when something enters or exits the inventory system.
	# Check current state of the array
	#print("Snapzone body exited CALLED")
	emit_signal("inventory_updated")
	_check_inventory_status()
