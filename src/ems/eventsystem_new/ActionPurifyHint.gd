extends Event

@onready var curse := $"../../cursed_floor"


func _on_cursed_floor_action_completed(requirement, total_progress):
	
	curse.queue_free()


func _on_cursed_floor_purify_hint_event_end():
	close_event()
