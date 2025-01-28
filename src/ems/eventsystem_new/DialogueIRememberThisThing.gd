extends Event
@onready var shotgun = $"../../shotgun"
@onready var howitzer_actual = $"../../Howitzer"
@onready var howitzer_round = $"../../howitzer_round"
@onready var distortion_crystal = $"../../DistortionCrystal10"


func _on_event_started():
	howitzer_actual.visible = true
	howitzer_round.visible = true
	shotgun.queue_free()
	play_event_audio()
	await event_audio_done
	quests.add_active_quest("QuestDestroytheCrystalsHowitzer")
	close_event()
