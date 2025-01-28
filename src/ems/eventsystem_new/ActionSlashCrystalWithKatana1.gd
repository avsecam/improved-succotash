extends Event

@onready var distortion_crystal = $"../../DistortionCrystal"
@onready var katana = $"../../katana"

func _on_event_started():
	quests.add_active_quest("QuestDestroytheCrystalsKatana")
	distortion_crystal.visible = true
	katana.visible = true

func _on_dark_crystal_slash():
	close_event()
