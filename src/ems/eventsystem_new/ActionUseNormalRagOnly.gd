extends Event


func _on_event_started():
	pass


func _on_clean_rag_receiver_action_completed(requirement, total_progress):
	print("trying to polish rod with normal rag")
	if is_instance_valid(AudioHandler.dialogue_player):
		if AudioHandler.dialogue_player.playing == false:
			play_event_audio()
	else:
		play_event_audio()

