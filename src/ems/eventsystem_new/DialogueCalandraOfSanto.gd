extends Event

signal secondary_emit

func _on_journal_pointer_event(event):
	if event.event_type == XRToolsPointerEvent.Type.PRESSED:
		if is_instance_valid(AudioHandler.dialogue_player):
			if AudioHandler.dialogue_player.playing == false:
				play_event_audio()
		else:
			play_event_audio()
	
		await event_audio_done
		secondary_emit.emit()
		close_event()
