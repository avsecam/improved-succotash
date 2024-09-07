extends Event

@onready var shelf = get_node("/root/Demo/Shelf")

func _on_event_started():
	shelf.inventory_updated.connect(_on_shelf_inventory_updated)
	await get_tree().create_timer(loop_interval).timeout
	play_event_audio()

func _on_shelf_inventory_updated():
	for element in shelf.inventory_array:
		if element != null:
			if element.name == "TheKey":
				print("The Key is In the Inventory")
				close_event()
