extends Node3D

@export var inventory_array = []
@export var inventory_size : int


# Called when the node enters the scene tree for the first time.
func _ready():

	inventory_array = get_tree().get_nodes_in_group("InventorySlot_Slots")
	inventory_size = inventory_array.size()
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

