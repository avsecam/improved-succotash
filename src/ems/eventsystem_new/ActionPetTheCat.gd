extends Event

@onready var mesh = $"../../Cat/MeshInstance3D2"


func _on_event_started():
	await get_tree().create_timer(loop_interval).timeout
	play_event_audio()
	
func _on_cat_pet_event_done():
	close_event()


func _on_cat_action_ended(requirement, total_progress):
	close_event()
