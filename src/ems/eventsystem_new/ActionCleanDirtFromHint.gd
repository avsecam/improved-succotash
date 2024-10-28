extends Event

@onready var dirt := $"../../dirt"

func _on_dirt_action_completed(requirement, total_progress):
	close_event()
	dirt.queue_free()
