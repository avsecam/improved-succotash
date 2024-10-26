extends Event


func _on_cooking_vat_long_new_kalabasa_soup_complete():
	quests.add_active_quest("QuestPrepareAtchara")
	close_event()
