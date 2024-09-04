extends Node


func _on_event_ended() -> void:
	await get_tree().create_timer(0.1).timeout
	for child in get_children():
		if not child.is_ongoing:
			child.start_event()
