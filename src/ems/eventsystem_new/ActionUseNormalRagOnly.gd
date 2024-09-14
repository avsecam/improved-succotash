extends Event


func _on_event_started():
	pass


func _on_clean_rag_receiver_action_completed(requirement, total_progress):
	print("trying to polish rod with normal rag")
	if AudioHandler.dialogue_player.playing == false:
		play_event_audio()
