extends XRToolsPickable

signal chicken_connect
signal chicken_connect_2
signal pole_inserted_inventory

@onready var slot_a = $InventorySlots_PoleBamboo/Slot
@onready var slot_b = $InventorySlots_PoleBamboo/Slot2
@onready var chicken_1 = $"MainMesh/Chicken_Whole Raw"
@onready var chicken_2 = $"MainMesh/Chicken_Whole Raw2"

func _on_snap_zone_item_inserted():
	chicken_connect.emit()
	
	if !is_instance_valid(slot_b):
		chicken_1.visible = true
		chicken_2.visible = true
		self_destruct()
	else:
		chicken_1.visible = true
	

func _on_snap_zone_item_inserted_2():
	chicken_connect_2.emit()
	
	if is_instance_valid(slot_b):
		chicken_2.visible = true
	else:
		chicken_1.visible = true
		chicken_2.visible = true
		self_destruct()
		
func self_destruct():
	await get_tree().create_timer(3).timeout
	pole_inserted_inventory.emit()
	self.queue_free()

		

		
