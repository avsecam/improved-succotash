extends Event


func _on_event_started():
	if "QuestPlaceAllTheCatIcons_Done" not in Events.finished_events:
		quests.add_active_quest("QuestPlaceAllTheCatIcons")
