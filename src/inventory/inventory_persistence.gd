extends Node

@export var global_inv_array = []
@export var inventory_size : int

func _ready():
	get_tree().call_group("InventorySlot_Shelf", "queue_free")
	

