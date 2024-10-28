extends Event

@onready var curse := $"../../cursed_floor"


func _on_cursed_floor_action_completed(requirement, total_progress):
	close_event()
	curse.queue_free()
