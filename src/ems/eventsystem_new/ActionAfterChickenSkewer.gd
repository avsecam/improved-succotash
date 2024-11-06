extends Event


# Called when the node enters the scene tree for the first time.

func _on_roasting_pit_pole_inserted_inventory():
	quests.add_active_quest("QuestKalabasaSoup")
	close_event()
