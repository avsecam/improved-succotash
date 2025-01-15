extends Event

@onready var cat_hitbox := $"../../Cat/CollisionShape3D"
@onready var cat := $"../../Cat"
@onready var cat_animation_player = $"../../Cat/MainMesh/Ginger Cat (rigged with IK)/Armature/Skeleton3D/AnimationPlayer"


func _on_event_started():
	play_event_audio()
	await get_tree().create_timer(1).timeout
	var tween = get_tree().create_tween()
	print(cat)
	tween.tween_property(cat, "rotation", Vector3(0, deg_to_rad(8), 0), 0.5).set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_LINEAR)
	tween.tween_property(cat, "position", Vector3(-0.204, -1.568, 4.214), 2.5).set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_LINEAR)
	cat_animation_player.play("cat_run")
	await tween.finished
	cat_animation_player.play("cat_idle")
	await get_tree().create_timer(1).timeout
	cat.visible = false
	await event_audio_done
	close_event()
