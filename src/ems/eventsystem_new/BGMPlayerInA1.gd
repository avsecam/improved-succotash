extends Event


func _on_event_started():
	if !Events.current_bgm == "BGMPlayerInA3":
		play_event_audio()
	 
