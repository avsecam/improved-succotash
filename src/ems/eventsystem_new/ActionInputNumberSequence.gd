extends Event

func _on_event_started() -> void:
	clear_event_dialogue()

func _on_numpad_correct_password_inputted():
	close_event()
