extends Event

@onready var shelf = get_node("/root/Demo/Shelf")
@export var rag : XRToolsPickable

func _on_event_started():
	shelf.inventory_updated.connect(_on_shelf_inventory_updated)
	await get_tree().create_timer(loop_interval).timeout

func _on_shelf_inventory_updated():
	for element in shelf.inventory_array:
		if element != null:
			if element.name == "Rag":
				print("The Rag is In the Inventory")
				close_event()

#func close_event() -> void:
	#rag.queue_free()
	#super()
