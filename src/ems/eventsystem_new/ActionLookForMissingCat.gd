extends Event

@onready var cat := $"../../Cat"
@onready var cat_animation_player = $"../../Cat/MainMesh/Ginger Cat (rigged with IK)/Armature/Skeleton3D/AnimationPlayer"
@onready var cat_on_screen_notif = $"../../Cat/CatOnScreenNotif"
@onready var cat_meow = $"../../Cat/CatMeow"
@onready var magical_gpu_particles_3d = $"../../Cat/MagicalDistortion/GPUParticles3D"

var audio_keep_playing_state : bool = true
var meow_signal_emitted : bool = false
var teleport_mesh : Teleporter

func _on_event_started():
	cat_animation_player.play("cat_idle")
	
	while audio_keep_playing_state and !meow_signal_emitted:
		print("play cat audio =======")
		cat_meow.play()
		await get_tree().create_timer(2).timeout
		meow_signal_emitted = false
	

func _on_cat_on_screen_notif_screen_entered():
	magical_gpu_particles_3d.emitting = false
	play_event_audio()
	await event_audio_done
	close_event()

func _on_cat_meow_finished():
	meow_signal_emitted = true
