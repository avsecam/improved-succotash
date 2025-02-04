extends Event

@onready var frame = $"../../Frame"

func _on_event_started():
	frame.visible = false
	play_event_audio()
	await event_audio_done
	quests.add_active_quest("QuestPetCatTutorial")
	close_event()
