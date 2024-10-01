extends WipeAction

func _associated_event_done() -> void:
	queue_free()
