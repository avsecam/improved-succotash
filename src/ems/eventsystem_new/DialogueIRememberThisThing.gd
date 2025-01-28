extends Event
@onready var shotgun = $"../../shotgun"
@onready var howitzer_actual = $"../../Howitzer_Actual"


func _on_event_started():
	howitzer_actual
	shotgun.queue_free()
	play_event_audio()
	await event_audio_done
	quests.add_active_quest("QuestDestroytheCrystalsHowitzer")
	close_event()
