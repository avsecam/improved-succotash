extends Event

@onready var distortion_crystal = $"../../DistortionCrystal"

func _on_event_started():
	quests.add_active_quest("QuestDestroytheCrystalsKatana")
	distortion_crystal.visible = true

func _on_distortion_crystal_action_completed(requirement, total_progress):
	close_event()
