extends Event

func _on_event_started() -> void:
	play_event_audio()
	await event_audio_done
	quests.add_active_quest("QuestMeetTheMarbleSpirit")
	close_event()
