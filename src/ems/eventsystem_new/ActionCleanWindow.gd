extends Event

func _on_event_started():
	pass

func _on_dirt_action_completed(requirement, total_progress):
	close_event()
