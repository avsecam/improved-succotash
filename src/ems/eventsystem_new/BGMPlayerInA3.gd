extends Event

@export var locked_teleporter : Node

func _on_event_started():
	if is_instance_valid(locked_teleporter):
		locked_teleporter.enabled = false
	play_event_audio()
	 
