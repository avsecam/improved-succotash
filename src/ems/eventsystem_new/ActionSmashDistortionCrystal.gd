extends Event

@onready var distortion_crystal := $"../../DistortionCrystal"
@onready var magical_distortion := $"../../MagicalDistortion/GPUParticles3D"
@onready var quest_bgm_event := $"../BGMPlayerInA3"

func _on_event_started():
	distortion_crystal.visible = true
	#await get_tree().create_timer(loop_interval).timeout
	play_event_audio()

func _on_distortion_crystal_action_completed(requirement, total_progress):
	close_event()
	magical_distortion.emitting = false
	
