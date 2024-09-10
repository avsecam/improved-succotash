extends Node


func add_active_quest(quest_name: String) -> void:
	var quest := Quest.new()
	quest.name = quest_name
	
	add_child(quest)
	quest.initialize_quest()
