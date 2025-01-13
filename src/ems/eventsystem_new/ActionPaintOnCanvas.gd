extends Event


func _on_canvas_paint_new_canvas_paint_complete():
	play_event_audio()
	await event_audio_done
	close_event() # Replace with function body.
