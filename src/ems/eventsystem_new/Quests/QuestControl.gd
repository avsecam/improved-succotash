extends Node

@onready var quest_tracker := get_tree().get_root().get_node("Demo/StaticUIContainer")

func add_active_quest(quest_name: String) -> void:
	var quest := Quest.new()
	quest.name = quest_name
	
	add_child(quest)
	quest.connect("quest_started", quest_tracker.quest_tracker_ui._add_quest)
	quest.connect("quest_updated", quest_tracker.quest_tracker_ui._update_quest_progress)
	quest.connect("quest_ended", quest_tracker.quest_tracker_ui._remove_quest)
	quest.initialize_quest()
	


func update_active_quests() -> void:
	print("ohno a quest has ended")
	for child in get_children():
		child.update_quest()
