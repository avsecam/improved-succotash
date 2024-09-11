extends Event

@onready var key = $"../../TheKey"
@onready var quests = get_tree().get_root().get_node("/root/Demo/Quests")

func _on_event_started():
	key.visible = false
	play_event_audio()
	await event_audio_done
	key.visible = true
	quests.add_active_quest("QuestOpenTheFrontGate")
	close_event()
