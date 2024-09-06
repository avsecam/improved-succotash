extends Event

@onready var marble_spirit = $"../../MarbleSpirit_Normal"

func _on_event_started():
	await get_tree().create_timer(loop_interval).timeout
	play_event_audio()
	var tween = get_tree().create_tween()
	print(marble_spirit)
	tween.tween_property(marble_spirit, "position", Vector3(3.875, 1, 2.113), 2.0).set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_LINEAR)
	
	await event_audio_done
	await tween.finished
	
	close_event()
