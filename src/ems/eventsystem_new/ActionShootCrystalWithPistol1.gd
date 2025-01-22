extends Event

@onready var distortion_crystal = $"../../DistortionCrystal4"

func _on_event_started():
	quests.add_active_quest("QuestDestroytheCrystalsPistol")
	distortion_crystal.visible = true

func _on_dark_crystal_shot():
	close_event()
	distortion_crystal.queue_free()
