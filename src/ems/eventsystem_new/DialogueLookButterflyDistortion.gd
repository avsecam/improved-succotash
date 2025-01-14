extends Event

func _on_event_started() -> void:
	clear_event_dialogue()
	await get_tree().create_timer(3.0).timeout
	play_event_audio()
	quests.add_active_quest("QuestLookAtTheButterflies")
