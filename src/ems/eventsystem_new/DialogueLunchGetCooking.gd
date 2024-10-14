extends Event


func _on_event_started():
	play_event_audio()
	await event_audio_done
	quests.add_active_quest("QuestCookLunch")
	await get_tree().create_timer(2).timeout
	quests.add_active_quest("QuestPrepareRoastChicken")
	await get_tree().create_timer(1).timeout
	close_event()
