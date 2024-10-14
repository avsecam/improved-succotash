extends Event

func _on_long_cooking_vat_action_ended(requirement, total_progress):
	quests.add_active_quest("QuestPrepareAtchara")
	close_event()
	
