extends Event


func _on_event_started():
	await get_tree().create_timer(loop_interval).timeout
	play_event_audio()


func _on_front_gate_action_completed(requirement, total_progress):
	close_event()
