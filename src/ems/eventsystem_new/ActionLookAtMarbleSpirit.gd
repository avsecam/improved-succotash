extends Event


func _on_event_started() -> void:
	await get_tree().create_timer(3.0).timeout
	play_event_audio()



func _on_visible_on_screen_notifier_3d_screen_entered():
	close_event()
