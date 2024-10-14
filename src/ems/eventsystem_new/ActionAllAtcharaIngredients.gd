extends Event

func _on_atchara_pot_atchara_complete():
	quests.add_active_quest("QuestPrepareDeepFriedSaba")
	close_event()
