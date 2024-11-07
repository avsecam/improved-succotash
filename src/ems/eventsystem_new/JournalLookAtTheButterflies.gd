extends Event

func _on_event_started() -> void:
	print("STARTS HERE")
	Events.locked_teleporters["Left1_jpg"] = "QuestLookAtTheButterflies_Done"
	get_parent().check_waypoints()

func _on_journal_pointer_event(event):
	if event.event_type == XRToolsPointerEvent.Type.PRESSED:
		if is_instance_valid(AudioHandler.dialogue_player):
			if AudioHandler.dialogue_player.playing == false:
				play_event_audio()
		else:
			play_event_audio()
	
		await event_audio_done
		
		quests.add_active_quest("QuestLookAtTheButterflies")
		clear_event_dialogue()
		
		close_event()
