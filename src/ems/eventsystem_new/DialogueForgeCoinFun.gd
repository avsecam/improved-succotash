extends Event


# Called when the node enters the scene tree for the first time.
func _on_event_started():
	play_event_audio()
	await event_audio_done
	close_event()
