extends Event

signal secondary_emit

@onready var shelf_reference = get_tree().get_root().get_node("/root/Demo/Shelf/InventoryController")

func _on_journal_pointer_event(event):
	if event.event_type == XRToolsPointerEvent.Type.PRESSED:
		if is_instance_valid(AudioHandler.dialogue_player):
			if AudioHandler.dialogue_player.playing == false:
				play_event_audio()
				shelf_reference.play_close_inventory_anim()
				AudioHandler.play_sfx("UI_Inventory_Toggle", $"../AudioStreamPlayer3D")
		else:
			play_event_audio()
			shelf_reference.play_close_inventory_anim()
			AudioHandler.play_sfx("UI_Inventory_Toggle", $"../AudioStreamPlayer3D")
	
		await event_audio_done
		secondary_emit.emit()
		close_event()
		
	
