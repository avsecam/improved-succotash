extends Event

@onready var shelf = get_node("/root/Demo/Shelf")

func _on_event_started():
	shelf.visible = false
	play_event_audio()
	await event_audio_done
	shelf.visible = true
	close_event()
