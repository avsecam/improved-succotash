extends Event

func _on_event_started():
	await get_tree().create_timer(loop_interval).timeout
	play_event_audio()

func _on_frame_picked_up(pickable):
	close_event()
