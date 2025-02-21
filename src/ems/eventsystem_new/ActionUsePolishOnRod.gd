extends Event



func _on_polish_receiver_action_completed(requirement, total_progress):
	print("trying to polish rod with metal polish")
	if is_instance_valid(AudioHandler.dialogue_player):
		if AudioHandler.dialogue_player.playing == false:
			play_event_audio()
			await event_audio_done
			clear_event_dialogue()
	else:
		play_event_audio()
		await event_audio_done
		clear_event_dialogue()
