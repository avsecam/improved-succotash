extends Event

@onready var frame = $"../../Frame"

func _on_event_started():
	frame.visible = false
	play_event_audio()
	await event_audio_done
	close_event()
