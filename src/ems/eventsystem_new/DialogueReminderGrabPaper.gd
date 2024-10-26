extends Event

func _on_event_started():
	play_event_audio()
	await event_audio_done
	quests.add_active_quest("QuestArrangeDocuments")
	close_event()
