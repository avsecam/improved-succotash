extends Event

func _on_small_crucible_ingot_is_melted():
	await get_tree().create_timer(0.1).timeout
	close_event()
