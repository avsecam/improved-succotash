extends Event

@onready var cat := $"../../Cat"
@onready var cat_animation_player = $"../../Cat/MainMesh/Ginger Cat (rigged with IK)/Armature/Skeleton3D/AnimationPlayer"


func _on_event_started():
	var tween = get_tree().create_tween()
	tween.tween_property(cat, "position", Vector3(-2.593, -1.568, 5.289), 4).set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_LINEAR)
	cat_animation_player.play("cat_run")
	await tween.finished
	cat.visible = false
	cat_animation_player.play("cat_idle")
	await event_audio_done
	close_event()
