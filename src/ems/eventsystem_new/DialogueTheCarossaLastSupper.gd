extends Event


func _on_journal_pointer_event(event):
	if event.event_type == XRToolsPointerEvent.Type.PRESSED:
		play_event_audio()
		await event_audio_done
		clear_event_dialogue()
