extends Event

@onready var quests = get_tree().get_root().get_node("/root/Demo/Quests")

func _on_event_started():
	play_event_audio()
	await event_audio_done
	quests.add_active_quest("QuestMeetTheMarbleSpirit")
	close_event()
