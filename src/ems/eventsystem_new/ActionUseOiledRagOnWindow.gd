extends Event




func _on_oiled_rag_receiver_action_completed(requirement, total_progress):
	if is_instance_valid(AudioHandler.dialogue_player):
		if AudioHandler.dialogue_player.playing == false:
			play_event_audio()
	else:
		play_event_audio()

