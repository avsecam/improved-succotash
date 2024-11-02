extends Event

@onready var look_around_checker = $"../../LookAroundChecker"


func _on_look_around_checker_all_markers_seen():
	print("all markers checked")
	close_event()

func _on_event_started() -> void:
	quests.add_active_quest("QuestLookAtTheButterflies")
	clear_event_dialogue()
	await get_tree().create_timer(3.0).timeout
	play_event_audio()
	look_around_checker.all_markers_seen.connect(_on_look_around_checker_all_markers_seen)
