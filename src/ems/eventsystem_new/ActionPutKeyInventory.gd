extends Event

@onready var earth_spirit = $"../../Shelf"

func _on_event_started():
	await get_tree().create_timer(loop_interval).timeout
	play_event_audio()

func _on_shelf_inventory_updated():
	for element in earth_spirit.inventory_array:
		if element != null:
			if element.name == "TheKey":
				close_event()
