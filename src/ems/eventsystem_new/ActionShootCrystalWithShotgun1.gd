extends Event

@onready var distortion_crystal = $"../../DistortionCrystal7"
@onready var shotgun = $"../../shotgun"
@onready var katana = $"../../katana"

func _on_event_started():
	#katana.queue_free()
	quests.add_active_quest("QuestDestroytheCrystalsShotgun")
	shotgun.visible = true
	distortion_crystal.visible = true


func _on_dark_crystal_shotgun():
	close_event()
