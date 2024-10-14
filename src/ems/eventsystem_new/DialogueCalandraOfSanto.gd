extends Event



func _on_journal_pointer_event(event):
	if event.event_type == XRToolsPointerEvent.Type.PRESSED:
		if is_instance_valid(AudioHandler.dialogue_player):
			if AudioHandler.dialogue_player.playing == false:
				play_event_audio()
		else:
			play_event_audio()
