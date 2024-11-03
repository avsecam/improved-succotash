extends Event

@export var locked_teleporter : Node

func _on_event_started():
	if is_instance_valid(locked_teleporter):
		locked_teleporter.enabled = false
	play_event_audio()
	 


func _on_distortion_crystal_action_completed(requirement, total_progress):
	print("Finished A3")
	Events.current_bgm == ""
	close_event()
	
