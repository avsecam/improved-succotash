extends Event

@onready var cat_hitbox := $"../../Cat/CollisionShape3D"
@onready var cat := $"../../Cat"

func _on_event_started():
	play_event_audio()
	await get_tree().create_timer(3).timeout
	var tween = get_tree().create_tween()
	print(cat)
	tween.tween_property(cat, "rotation", Vector3(0, deg_to_rad(8), 0), 0.2).set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_LINEAR)
	tween.tween_property(cat, "position", Vector3(-0.204, -1.568, 4.214), 1).set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_LINEAR)
	await tween.finished
	cat.visible = false
	await event_audio_done
	
	close_event()
