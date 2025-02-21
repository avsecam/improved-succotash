extends Event

@onready var catyaw = $"../../Cat"
@onready var cat_animation_player = $"../../Cat/MainMesh/Ginger Cat (rigged with IK)/Armature/Skeleton3D/AnimationPlayer"
@onready var cat_on_screen_notif = $"../../Cat/CatOnScreenNotif"
@onready var cat_meow = $"../../Cat/CatMeow"

var audio_keep_playing_state : bool = true
var meow_signal_emitted : bool = false
var teleport_mesh : Teleporter
var ensure_journal_read : bool = false
var cat_on_screen : bool = false

func _on_event_started():
	teleport_mesh = get_parent().get_parent().teleporters_container.get_node("2Left13_jpg")
	catyaw.rotation.y = atan2(-3.742, 1.073)
	
	while audio_keep_playing_state and !meow_signal_emitted:
		print("play cat audio =======")
		cat_meow.play()
		await get_tree().create_timer(2).timeout
		meow_signal_emitted = false
	

func _on_cat_on_screen_notif_screen_entered():
	cat_on_screen = true
	print("cat notif on screen =======")
	if ensure_journal_read:
		await get_tree().create_timer(1).timeout
		audio_keep_playing_state = false
		var tween = get_tree().create_tween()
		tween.tween_property(catyaw, "position", Vector3(-3.742, -2.259, 1.073), 2).set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_LINEAR)
		cat_animation_player.play("cat_run")
		await tween.finished
		catyaw.visible = false
		cat_animation_player.play("cat_idle")
		close_event()


func _on_cat_meow_finished():
	meow_signal_emitted = true


func _on_journal_weapon_collection_secondary_emit():
	ensure_journal_read = true


func _on_cat_on_screen_notif_screen_exited():
	cat_on_screen = false
