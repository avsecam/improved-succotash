extends Event

@onready var distortion_crystal = $"../../DistortionCrystal8"

func _on_event_started():
	distortion_crystal.visible = true


func _on_dark_crystal_shotgun():
	close_event()
