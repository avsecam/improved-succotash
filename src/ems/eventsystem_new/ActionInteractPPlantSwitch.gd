extends Event


func _on_top_lever_area_pointer_event(event):
	if event.event_type == XRToolsPointerEvent.Type.PRESSED:
		print("YOU DID THIS")
		if is_instance_valid(AudioHandler.dialogue_player):
			if AudioHandler.dialogue_player.playing == false:
				play_event_audio()
		else:
			play_event_audio()
	
		await event_audio_done
		close_event()
