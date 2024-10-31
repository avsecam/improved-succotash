extends Event

@onready var back_2_jpg = $"../../Teleporters/Back2_jpg"

func _on_event_started():
	play_event_audio()
	await event_audio_done
	quests.add_active_quest("QuestRetrievePainting")
	close_event()
