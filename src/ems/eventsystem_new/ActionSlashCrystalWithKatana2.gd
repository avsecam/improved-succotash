extends Event

@onready var distortion_crystal = $"../../DistortionCrystal2"

func _on_event_started():
	distortion_crystal.visible = true

func _on_dark_crystal_slash():
	close_event()
