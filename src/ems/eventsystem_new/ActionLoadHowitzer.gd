extends Event
@onready var howitzer_round = $"../../howitzer_round"
@onready var howitzer_loader = $"../../Howitzer/XRToolsInteractableArea"

func _on_event_started() -> void:
	clear_event_dialogue()
	await get_tree().create_timer(3.0).timeout
	play_event_audio()
	quests.add_active_quest("QuestDestroytheCrystalsHowitzer")
	howitzer_round.visible = true

func _on_xr_tools_interactable_area_loaded_howitzer():
	print("HOWITZER IS LOADED")
	close_event()
