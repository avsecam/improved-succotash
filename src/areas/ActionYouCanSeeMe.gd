extends Event

@onready var marble_spirit = $"../../MarbleSpirit_Normal"

func _on_event_started():
	await get_tree().create_timer(3).timeout
	play_event_audio()
	await get_tree().create_timer(9).timeout
	var tween = get_tree().create_tween()
	print(marble_spirit)
	tween.tween_property(marble_spirit, "position", Vector3(0.313, 1, -4.459), 2.0).set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_LINEAR)
	
	await event_audio_done
	await tween.finished
	close_event()
