extends Event

@onready var distortion_crystal = $"../../DistortionCrystal4"
@onready var pistol = $"../../pistol"
@onready var katana = $"../../katana"

func _on_event_started():
	katana.queue_free()
	quests.add_active_quest("QuestDestroytheCrystalsPistol")
	pistol.visible = true
	distortion_crystal.visible = true

func _on_dark_crystal_shot():
	close_event()
