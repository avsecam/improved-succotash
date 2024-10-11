extends Event


# Called when the node enters the scene tree for the first time.

@export var roasting_pit: Node3D

func _on_pole_bamboo_chicken_new_pole_inserted_inventory():
	roasting_pit.pole_visible.visible = true
	
	print("DID THIS GET CALLED ASLDKJALKDJASDLKAJSDLKAJSDLAKSJDALSKDJASDLKAJSD")
