extends Event

@onready var distortion_crystal = $"../../DistortionCrystal"

func _on_event_started():
	distortion_crystal.visible = true

func _on_distortion_crystal_3_action_completed(requirement, total_progress):
	close_event()
