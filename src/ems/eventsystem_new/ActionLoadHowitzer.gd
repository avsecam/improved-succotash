extends Event

func _on_event_started() -> void:
	clear_event_dialogue()
	await get_tree().create_timer(3.0).timeout
	play_event_audio()



func _on_xr_tools_interactable_area_loaded_howitzer():
	close_event()
