extends Event


func _on_event_started():
	await get_tree().create_timer(loop_interval).timeout
	play_event_audio()

func _on_kalabasa_kalabasa_chopped():
	close_event()
