extends Event

@onready var shelf = get_node("/root/Demo/Shelf")

func _on_event_started():
	print("Current BGM" + str(Events.current_bgm))
	if !Events.current_bgm == "BGMPlayerInA3":
		play_event_audio()
	shelf.visible = true
	
	 
