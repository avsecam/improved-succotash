extends Event

@onready var frame = $"../../Frame"

func _on_event_started():
	await get_tree().create_timer(loop_interval).timeout
	frame.visible = false
	play_event_audio()
	frame.visible = true

func _on_frame_picked_up(pickable):
	close_event()
